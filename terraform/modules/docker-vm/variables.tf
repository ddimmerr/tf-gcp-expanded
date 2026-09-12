variable "project_id" {
  type        = string
  default     = "gcp-tf-508315" # GCP Project ID
}

variable "ssh_public_key" {
  type        = string
  description = "The public SSH key for GitHub Actions deployment access"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD9k3u5ognXYK2cQl/qX64S7QeZHa8wPtlwoQ/d9/MfwAGowGT6StXp4zMTmQFriRYRZ/b9MkcA8wW+yEKbpAf2Ld3vPtxr9yr7Zgea2HPxOYSdV1ci1MxnWllyntklYme2aV1d8sP3/rpxgnPQuejLJIyPUtIUFoSz3Pot3+oGzmBV8SaslwNc2Z21R5p37eS8bGfbpQSIlknef2U3RmNcvjb/pvbl/uTvz6/+dAdS91qSlOeCyHdaSp/W6Ad/T2KJTvpV8kcXP3ysoJndksh7FVZjXwx3a/TqkT2vuMyD0omH+47twP/kFe0AC2x16c9ChiEoi84jMY18XpawokxSZoMXd5RcVMyiFwWdpkPyjC9SD4iMMg+0SHyI177do/gRWG2uxaxEPF3D3sOHdIdBmdn+qsILOKWBGMoo0EMcRhTB9qtO6tSPK5YdThOaI63oF+h9rMuhUWqf+sBUtm/ispcznDh5sSdbSCO0K5Uui9kPHsXitmDyengjyYOudYvhnnL9ZnuMpayR0xqzwS9c0W3DGA4h1tIjDfeZ0GpLlToUtJIdm618PYjj0dgYmNi59dWAsG35vPtVUxUTsREW/1zkRmgun00y+c5ZfHyuV752dGPImMkKcai45/tLedMtRw9Ym7JQbEt4nzT+S6vs6H0Qik4iH9h8CF2wxVPWpw== github-actions-gcp" 
}
