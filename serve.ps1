$prefix = 'http://localhost:8000/'
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($prefix)
$listener.Start()
Write-Host "Servidor HTTP iniciado em $prefix - pressione Ctrl+C para parar."
try {
  while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response
    $urlPath = [System.Uri]::UnescapeDataString($request.Url.AbsolutePath.TrimStart('/'))
    if ([string]::IsNullOrEmpty($urlPath)) { $urlPath = 'portfolio-grazzarte/index.html' }
    $filePath = Join-Path (Get-Location) $urlPath
    if (-not (Test-Path $filePath)) {
      $response.StatusCode = 404
      $buffer = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $urlPath")
      $response.OutputStream.Write($buffer, 0, $buffer.Length)
      $response.Close()
      continue
    }
    $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
    $mime = switch ($ext) {
      '.html' { 'text/html' }
      '.htm' { 'text/html' }
      '.css' { 'text/css' }
      '.js' { 'application/javascript' }
      '.png' { 'image/png' }
      '.jpg' { 'image/jpeg' }
      '.jpeg' { 'image/jpeg' }
      '.gif' { 'image/gif' }
      '.svg' { 'image/svg+xml' }
      default { 'application/octet-stream' }
    }
    $bytes = [System.IO.File]::ReadAllBytes($filePath)
    $response.ContentType = $mime
    $response.ContentLength64 = $bytes.Length
    $response.OutputStream.Write($bytes, 0, $bytes.Length)
    $response.Close()
  }
} finally {
  $listener.Stop()
  $listener.Close()
}