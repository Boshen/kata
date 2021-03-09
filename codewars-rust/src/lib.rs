pub struct Codewars {}

impl Codewars {
    // Roman Numerals Encoder
    pub fn num_as_roman(num: i32) -> String {
        let codes = [
            ("M", 1000),
            ("CM", 900),
            ("D", 500),
            ("CD", 400),
            ("C", 100),
            ("XC", 90),
            ("L", 50),
            ("XL", 40),
            ("X", 10),
            ("IX", 9),
            ("V", 5),
            ("IV", 4),
            ("I", 1),
        ];
        let mut number = num;
        let mut s = String::new();
        for (roman, n) in codes.iter() {
            while *n <= number {
                s += roman;
                number -= n;
            }
        }
        s
    }

    // Difference of Volumes of Cuboids
    pub fn find_difference(a: &[i32; 3], b: &[i32; 3]) -> i32 {
        (a.iter().product::<i32>() - b.iter().product::<i32>()).abs()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn num_as_roman() {
        assert_eq!(Codewars::num_as_roman(182), "CLXXXII");
        assert_eq!(Codewars::num_as_roman(1990), "MCMXC");
        assert_eq!(Codewars::num_as_roman(1875), "MDCCCLXXV");
    }

    #[test]
    fn find_different() {
        assert_eq!(Codewars::find_difference(&[3, 2, 5], &[1, 4, 4]), 14);
        assert_eq!(Codewars::find_difference(&[9, 7, 2], &[5, 2, 2]), 106);
        assert_eq!(Codewars::find_difference(&[11, 2, 5], &[1, 10, 8]), 30);
        assert_eq!(Codewars::find_difference(&[4, 4, 7], &[3, 9, 3]), 31);
        assert_eq!(Codewars::find_difference(&[15, 20, 25], &[10, 30, 25]), 0);
    }
}
