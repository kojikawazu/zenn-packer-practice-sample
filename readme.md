# Packer練習用

# コードのフォーマット

```bash
packer fmt .
```

# AMIのビルド

```bash
packer build -var-file=variables.pkrvars.hcl .
```

既存のAMIがある場合は一度削除してください。