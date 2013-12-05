println( (for(a ← 1 until 100; b ← 1 until 100) yield BigInt(a).pow(b)).map(s=>s.toString.map(_.asDigit).sum).max )
