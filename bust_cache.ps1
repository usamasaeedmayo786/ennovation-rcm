$files = Get-ChildItem -Path . -Recurse -Filter "*.html"
foreach ($file in $files) {
    $content = Get-Content $file.FullName
    $content = $content -replace 'href="assets/custom-enhancements.css\?v=2"', 'href="assets/custom-enhancements.css?v=3"'
    Set-Content -Path $file.FullName -Value $content
}
