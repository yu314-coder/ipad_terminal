# One-time setup: GitHub Secrets (for TestFlight CI)

Add these **Repository secrets** (Settings → Secrets and variables → Actions → New repository secret):

- `IOS_CERT_P12_BASE64` — your signing certificate (`.p12`) base64-encoded  
- `IOS_CERT_P12_PASSWORD` — password for the `.p12`
- `IOS_MOBILEPROVISION_BASE64` — your provisioning profile (`.mobileprovision`) base64-encoded
- `ASC_KEY_ID` — App Store Connect API Key ID
- `ASC_ISSUER_ID` — App Store Connect Issuer ID
- `ASC_KEY_P8_BASE64` — App Store Connect private key (`.p8`) base64-encoded

## How to base64-encode on any OS

**macOS/Linux**
```bash
base64 -i SigningCert.p12 > signing.p12.b64
base64 -i BuildProfile.mobileprovision > build_pp.mobileprovision.b64
base64 -i AuthKey_ABC123XYZ.p8 > AuthKey.p8.b64
```

**Windows PowerShell**
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("SigningCert.p12")) > signing.p12.b64
```

Then paste the file contents into the corresponding GitHub secret.
