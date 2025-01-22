# v 2.0
# Author: Jonah Tan
# .\run.ps1 <send/receive> <filename>

$mode = $args[0]
$filename = $args[1]

switch ($mode) {
	"send" {
		switch ($psversiontable.PSVersion.Major) {
			"7" { $base64string = [convert]::ToBase64String((Get-Content -path $filename -AsByteStream)) }
			"5" { $base64string = [convert]::ToBase64String((Get-Content -path $filename -Raw -Encoding Byte)) }
		}
		Set-Clipboard -Value $base64string
		Get-FileHash $filename -Algorithm md5
		Start-Process "https://github.com/picar0jsu/Transfer.ps1/blob/main/transfer"
	}
	"receive" {
		$data = curl https://raw.githubusercontent.com/picar0jsu/Transfer.ps1/main/transfer
		[IO.File]::WriteAllBytes($filename, [System.Convert]::FromBase64String($data))
	}
}