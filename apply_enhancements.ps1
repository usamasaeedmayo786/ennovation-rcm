$BaseDir = "C:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm"
$htmlFiles = Get-ChildItem -Path $BaseDir -Filter *.html

$cssLink = "`n<link rel=`"stylesheet`" href=`"assets/custom-enhancements.css`">"
$jsLink = "`n<script src=`"assets/custom-enhancements.js`"></script>"

foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    
    # 1. Inject CSS and JS (only if not already there)
    if (-not ($content -match "custom-enhancements.css")) {
        $content = $content -replace "</head>", ($cssLink + "</head>")
        $content = $content -replace "</body>", ($jsLink + "</body>")
    }

    # 2. Add Geographical Mentions
    # Safe replacements that will read naturally
    $content = $content -replace "(?i)(?<!proudly serving the United States and Canada )medical billing company", "medical billing company proudly serving the United States and Canada"
    $content = $content -replace "(?i)(?<!across the United States and Canada )revenue cycle management services", "revenue cycle management services across the United States and Canada"

    # 3. Replace Hero Image (group_35700.webp) with custom generated image
    $content = $content -replace "https://www.dastifysolutions.com/wp-content/uploads/2026/01/group_35700.webp", "assets/medical_team.png"
    # Clear out the srcset so it doesn't fall back to the old webp image on smaller screens
    $content = $content -replace 'imagesrcset="[^"]*"', 'imagesrcset="assets/medical_team.png"'
    $content = $content -replace 'srcset="[^"]*"', 'srcset="assets/medical_team.png"'
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "All CSS, JS, Pictures, and Content Updates have been successfully injected into all pages!"
