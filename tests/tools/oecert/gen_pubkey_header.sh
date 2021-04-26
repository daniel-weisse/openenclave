#!/usr/bin/env bash

# Copyright (c) Open Enclave SDK contributors.
# Licensed under the MIT License.

destfile="$1"
pubkey_file="$2"

cat > "$destfile" << EOF
// Copyright (c) Open Enclave SDK contributors.
// Licensed under the MIT License.

#ifndef OECERT_PUBKEY_H
#define OECERT_PUBKEY_H

EOF

printf 'static const char OECERT_ENC_PUBLIC_KEY[] =' >> "$destfile"
while IFS="" read -r p || [ -n "$p" ]
do
    # Sometimes openssl can insert carriage returns into the PEM files. Let's remove those!
    CR=$(printf "\r")
    p=$(echo "$p" | tr -d "$CR")
    printf '\n    \"%s\\n\"' "$p" >> "$destfile"
done < "$pubkey_file"
printf ';\n' >> "$destfile"

cat >> "$destfile" << EOF

#endif /* OECERT_ENC_PUBLIC_KEY */
EOF
