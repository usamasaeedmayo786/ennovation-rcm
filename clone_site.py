import os
import re
import urllib.request
import urllib.error

BASE_DIR = r"C:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm"
INDEX_PATH = os.path.join(BASE_DIR, "index.html")
BASE_URL = "https://www.dastifysolutions.com"

# Read the local index.html to find URLs
with open(INDEX_PATH, 'r', encoding='utf-8') as f:
    index_content = f.read()

# Find all internal relative links ending with a slash
url_pattern = re.compile(r'href="(/[a-zA-Z0-9-][^"]*/)"')
urls = list(set(url_pattern.findall(index_content)))

# Function to flatten a URL path to a local filename
def flatten_url(url_path):
    if url_path == "/" or url_path == "":
        return "index.html"
    
    # Remove leading and trailing slashes
    clean_path = url_path.strip("/")
    
    # Replace intermediate slashes with hyphens
    flat_name = clean_path.replace("/", "-") + ".html"
    return flat_name

# Add '/' to the list of URLs to process if it's not there, but wait, 
# we already downloaded index.html. We just need to process it.
urls = [u for u in urls if u != "/"] # Exclude root, we handle it separately

def process_content(content):
    # 1. Branding replacements
    # Using simple replace is safe here since we are case sensitive
    content = content.replace("Dastify Solutions", "E-nnovationrcm")
    content = content.replace("Dastify", "E-nnovationrcm")
    
    # 2. Logo replacements
    content = content.replace("https://www.dastifysolutions.com/wp-content/uploads/2025/05/dastifysolutions-logo.webp", "assets/logo.png")
    content = content.replace("https://www.dastifysolutions.com/wp-content/uploads/2025/09/dastify-solutions-logo-white.webp", "assets/logo.png")
    
    # 3. Link replacements
    # We find all href="/something/" and replace with href="something.html"
    def link_replacer(match):
        original_href = match.group(1)
        return f'href="{flatten_url(original_href)}"'
    
    content = re.sub(r'href="(/[a-zA-Z0-9-][^"]*/)"', link_replacer, content)
    content = re.sub(r'href="/"', 'href="index.html"', content)
    return content

print(f"Found {len(urls)} internal pages to download.")

# Download and process each page
for url_path in urls:
    full_url = BASE_URL + url_path
    flat_filename = flatten_url(url_path)
    save_path = os.path.join(BASE_DIR, flat_filename)
    
    print(f"Downloading {full_url} -> {flat_filename} ...")
    
    try:
        # User-Agent is needed sometimes to bypass basic bot protection
        req = urllib.request.Request(full_url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req) as response:
            html = response.read().decode('utf-8')
            
        processed_html = process_content(html)
        
        with open(save_path, 'w', encoding='utf-8') as f:
            f.write(processed_html)
            
    except Exception as e:
        print(f"Error downloading {full_url}: {e}")

# Process the index.html file itself to flatten its links
print("Processing index.html ...")
index_content = process_content(index_content)
with open(INDEX_PATH, 'w', encoding='utf-8') as f:
    f.write(index_content)

print("Done! All pages cloned and flattened.")
