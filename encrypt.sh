#!/bin/bash
EphemeralPrivateKey=$(openssl ecparam -genkey -param_enc explicit -name secp256k1)
PrivateKeyBuffer="$(mktemp)"
PeerPublicKey="submitkey.pub"
PlainTextFile="$1"
EphemeralPublicKeyFile="temp.pub"
CipherTextFile="$1.enc"
MACFile="temp.mac"
echo -n "$EphemeralPrivateKey" > $PrivateKeyBuffer
ProcessedDerivedSharedSecret=$(openssl pkeyutl -derive -inkey $PrivateKeyBuffer -peerkey $PeerPublicKey|openssl dgst -sha256) #derive the symmetric key using SHA-256 from the established secret

rm $PrivateKeyBuffer
ProcessedDerivedSharedSecret=${ProcessedDerivedSharedSecret#*= }

openssl enc -base64 -aes-256-ofb -iv "0000000000000000000000000000000" -K "$ProcessedDerivedSharedSecret" -in "$PlainTextFile" -out "$CipherTextFile" #encrypt using 0 IV and SHA-256 as key
MACValue=$(openssl dgst -sha256 -hmac "$ProcessedDerivedSharedSecret" "$CipherTextFile") #MAC it
MACValue=${MACValue#*= } #strip the (stdin)=
echo -n "$MACValue" > "$MACFile"  #write the MAC
echo -n "$EphemeralPrivateKey" | openssl ec -param_enc explicit -pubout -out "$EphemeralPublicKeyFile" #write the ephemeral public key

echo "Please remember to check in $1.enc!"
