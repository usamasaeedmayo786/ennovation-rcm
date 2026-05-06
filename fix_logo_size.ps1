$htmlFiles = Get-ChildItem -Path "c:\Users\hp\.gemini\antigravity\scratch\ennovation-rcm" -Filter *.html -Recurse

$styleToInject = "<style>.headerlogoimg { width: 220px !important; max-width: 100% !important; flex-shrink: 0; } .headerlogoimg img { width: 100% !important; height: auto !important; }</style>`n</head>"

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw

    if ($content -notmatch "\.headerlogoimg \{ width: 220px") {
        $content = $content -replace "</head>", $styleToInject
        Set-Content -Path $file.FullName -Value $content
        Write-Host "Updated $($file.Name)"
    }
}
