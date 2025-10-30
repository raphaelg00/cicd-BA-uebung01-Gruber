package com.example.cicd;

public class TextUtils {

    public static boolean isPalindrome(String input) {
        if (input == null) return false;
        String reversed = new StringBuilder(input).reverse().toString();
        return input.toLowerCase().equals(reversed.toLowerCase());  // korrigiert
    }

    // Leerer Catch-Block + sehr generische Exception
    public static int safeParseInt(String s) {
        try {
            return Integer.parseInt(s);
        } catch (NumberFormatException e) {
            // absichtlich leer gelassen
        }
        return 0; // „Fallback“ – diskutabel
    }
}
