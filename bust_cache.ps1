$files = Get-ChildItem -Path . -Recurse -Filter "*.html"
foreach ($file in $files) {
    $content = Get-Content $file.FullName
    $content = $content -replace 'href="assets/custom-enhancements.css\?v=5"', 'href="assets/custom-enhancements.css?v=6"'
    Set-Content -Path $file.FullName -Value $content
}
