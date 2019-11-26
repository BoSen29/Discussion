function add-UDCache {
  param (
    $newVar
  )
  
  $temp = $cache:array
  
  $temp += $newVar
  
  $cache:array = $temp
}
