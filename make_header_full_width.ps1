$htmlFiles = Get-ChildItem -Path "c:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm" -Filter *.html -Recurse

$styleToInject = "<style>header.elementor-location-header .e-con { max-width: 100% !important; width: 100% !important; padding-left: 2%; padding-right: 2%; }</style>`n</head>"

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw

    if ($content -notmatch "header\.elementor-location-header \.e-con") {
        $content = $content -replace "</head>", $styleToInject
        Set-Content -Path $file.FullName -Value $content
        Write-Host "Updated $($file.Name)"
    }
}
