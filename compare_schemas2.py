import re

def parse_sql(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        content = f.read()
    
    tables = {}
    create_table_pattern = re.compile(r"CREATE TABLE `([^`]+)` \((.*?)\) ENGINE=InnoDB", re.DOTALL)
    
    for match in create_table_pattern.finditer(content):
        table_name = match.group(1)
        columns_and_keys = match.group(2)
        
        lines = []
        for line in columns_and_keys.split('\n'):
            line = line.strip()
            if not line:
                continue
            # Remove collation and charset
            line = re.sub(r" COLLATE [a-zA-Z0-9_]+", "", line)
            line = re.sub(r" CHARACTER SET [a-zA-Z0-9_]+", "", line)
            lines.append(line)
            
        tables[table_name] = lines

    return tables

def main():
    hosted = parse_sql('Hosted.sql')
    local = parse_sql('localhost.sql')
    
    with open('real_diff_output.txt', 'w', encoding='utf-8') as out:
        for table in local:
            if table not in hosted:
                out.write(f"NEW TABLE: {table}\n")
                out.write("\n".join(local[table]) + "\n\n")
            else:
                hosted_lines = set(hosted[table])
                local_lines = set(local[table])
                
                added = [line for line in local[table] if line not in hosted_lines]
                removed = [line for line in hosted[table] if line not in local_lines]
                
                if added or removed:
                    out.write(f"ALTER TABLE: {table}\n")
                    if added:
                        out.write("  ADDED:\n")
                        for line in added:
                            out.write(f"    {line}\n")
                    if removed:
                        out.write("  REMOVED:\n")
                        for line in removed:
                            out.write(f"    {line}\n")
                    out.write("\n")
                    
        for table in hosted:
            if table not in local:
                out.write(f"REMOVED TABLE: {table}\n\n")

if __name__ == "__main__":
    main()
