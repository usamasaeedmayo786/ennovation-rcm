$htmlFiles = Get-ChildItem -Path "c:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm" -Filter *.html -Recurse

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8

    # Replace the footer logo specifically
    if ($content -match 'wp-image-30854" alt="" src="assets/logo.png"') {
        $content = $content -replace 'wp-image-30854" alt="" src="assets/logo.png"', 'wp-image-30854" alt="" src="assets/logo-white.png"'
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "Updated $($file.Name)"
    }
}
