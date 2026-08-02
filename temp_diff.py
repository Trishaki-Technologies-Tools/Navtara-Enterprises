import re

def parse_sql(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        content = f.read()
    tables = {}
    pattern = re.compile(r"CREATE TABLE `([^`]+)` \((.*?)\) ENGINE=InnoDB", re.DOTALL)
    for m in pattern.finditer(content):
        table_name = m.group(1)
        lines = []
        for line in m.group(2).split('\n'):
            line = line.strip()
            if not line or line.startswith('--') or line.startswith('/*'): continue
            # Normalize whitespace and trailing commas
            line = re.sub(r'\s+', ' ', line)
            line = line.rstrip(',')
            # Remove collations/character sets for easier comparison
            line = re.sub(r' COLLATE [a-zA-Z0-9_]+', '', line)
            line = re.sub(r' CHARACTER SET [a-zA-Z0-9_]+', '', line)
            # Normalizing DEFAULT values like DEFAULT 'Active' vs DEFAULT Active
            line = line.replace("DEFAULT current_timestamp()", "DEFAULT CURRENT_TIMESTAMP")
            lines.append(line)
        tables[table_name] = lines
    return tables

hosted = parse_sql('Hosted.sql')
local = parse_sql('Localhost.sql')

with open('schema_diff_output.txt', 'w', encoding='utf-8') as out:
    for t in local:
        if t not in hosted:
            out.write(f"NEW TABLE: {t}\n")
        else:
            hosted_cols = set(hosted[t])
            local_cols = set(local[t])
            added = local_cols - hosted_cols
            removed = hosted_cols - local_cols
            if added or removed:
                out.write(f"ALTER TABLE `{t}`\n")
                if added:
                    out.write("  -- MISSING IN HOSTED (Need to add):\n")
                    for a in added:
                        out.write(f"  {a}\n")
                if removed:
                    out.write("  -- EXTRA IN HOSTED (Need to remove/alter):\n")
                    for r in removed:
                        out.write(f"  {r}\n")
                out.write("\n")
