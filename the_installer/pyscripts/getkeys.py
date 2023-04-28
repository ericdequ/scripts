import json

def extract_keys_and_headers(data):
    keys = []
    headers = set()

    for key, value in data.items():
        keys.append(key)

        for inner_key in value:
            headers.add(inner_key)

    return {"keys": keys, "headers": list(headers)}

def main():
    loadjson = 'C:/Users/ericd/Desktop/scripts/the_installer/data.json'
    exportjson = 'C:/Users/ericd/Desktop/scripts/the_installer/results.json'
    
    with open(loadjson, 'r') as file:
        data = json.load(file)
    
    result = extract_keys_and_headers(data)

    with open(exportjson, 'w') as outfile:
        json.dump(result, outfile, indent=4)

if __name__ == "__main__":
    main()
