$BaseDir = "C:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm"
$htmlFiles = Get-ChildItem -Path $BaseDir -Filter *.html

foreach ($file in $htmlFiles) {
    $content = Get-Content -Raw $file.FullName
    
    # 1. Fix broken logo filenames caused by previous text replacements
    # This regex matches any URL ending with the broken logo filename and replaces the whole URL with the local logo.
    $content = $content -replace "https?://[^`"']*cropped-E-nnovationrcmsolutions-logo[^`"']*\.png", "assets/logo.png"
    $content = $content -replace "/wp-content/[^`"']*cropped-E-nnovationrcmsolutions-logo[^`"']*\.png", "assets/logo.png"
    
    # 2. Fix Relative Asset Paths
    # WordPress loads many images, icons, and scripts from /wp-content/ and /wp-includes/
    $content = $content -replace 'src="/wp-', 'src="https://www.dastifysolutions.com/wp-'
    $content = $content -replace 'data-lazy-src="/wp-', 'data-lazy-src="https://www.dastifysolutions.com/wp-'
    $content = $content -replace 'srcset="/wp-', 'srcset="https://www.dastifysolutions.com/wp-'
    $content = $content -replace 'url\(''/wp-', 'url(''https://www.dastifysolutions.com/wp-'
    $content = $content -replace 'url\("/wp-', 'url("https://www.dastifysolutions.com/wp-'
    $content = $content -replace 'href="/wp-', 'href="https://www.dastifysolutions.com/wp-'

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Picture QA and Asset Path fixes complete on all files!"
