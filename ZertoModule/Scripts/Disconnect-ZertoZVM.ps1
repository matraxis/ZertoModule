Function Disconnect-ZertoZVM {
    Remove-ZertoAuthToken
    Remove-Item ENV:ZertoVersion -Force -ErrorAction Ignore
    Remove-Item ENV:ZertoServer -Force -ErrorAction Ignore
    Remove-Item ENV:ZertoPort -Force -ErrorAction Ignore
    Remove-Item ENV:ZertoToken -Force -ErrorAction Ignore
}  #endregion  #region Zerto Rest API
# .
