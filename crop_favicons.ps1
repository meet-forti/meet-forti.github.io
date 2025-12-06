Add-Type -AssemblyName System.Drawing

$files = @(
    "FORTI MAIN.png",
    "FORTI design.png",
    "FORTI tech.png",
    "FORTI security.png"
)

foreach ($file in $files) {
    $fullPath = Join-Path (Get-Location) $file
    if (Test-Path $fullPath) {
        try {
            # Load image
            $img = [System.Drawing.Image]::FromFile($fullPath)
            $width = $img.Width
            $height = $img.Height
            $minSize = [Math]::Min($width, $height)

            # Create new bitmap with transparency
            $bmp = New-Object System.Drawing.Bitmap($minSize, $minSize)
            $gfx = [System.Drawing.Graphics]::FromImage($bmp)
            $gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
            
            # Create texture brush from original image
            $brush = New-Object System.Drawing.TextureBrush($img)
            
            # Fill ellipse (circle)
            $gfx.FillEllipse($brush, 0, 0, $minSize, $minSize)
            
            $gfx.Dispose()
            $brush.Dispose()
            $img.Dispose()

            # Save
            $bmp.Save($fullPath, [System.Drawing.Imaging.ImageFormat]::Png)
            $bmp.Dispose()
            
            Write-Host "Processed: $file"
        }
        catch {
            Write-Host "Error processing $file : $_"
        }
    }
    else {
        Write-Host "File not found: $file"
    }
}
