def isPalindrome(s: String): Boolean = s == s.reverse
println((for ( i <- Range(999, 99, -1); j <- Range(999, 99, -1); p = i * j; if isPalindrome(p.toString)) yield p).max)
