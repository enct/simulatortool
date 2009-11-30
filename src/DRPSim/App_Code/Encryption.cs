namespace DRPSim
{
	using System;
	using System.Security.Cryptography;
	using System.Text;

	internal static class Encryption
	{
		public static string EncodePassword(string password, string salt)
		{
			byte[] passwordBytes = Encoding.Unicode.GetBytes(password);
			byte[] saltBytes = Convert.FromBase64String(salt);
			byte[] encryptionText = new byte[passwordBytes.Length + saltBytes.Length];
			
			Buffer.BlockCopy(saltBytes, 0, encryptionText, 0, saltBytes.Length);
			Buffer.BlockCopy(passwordBytes, 0, encryptionText, saltBytes.Length, passwordBytes.Length);

			HashAlgorithm hashAlgorithm = HashAlgorithm.Create();
			byte[] hashedPassword = hashAlgorithm.ComputeHash(encryptionText);

			return Convert.ToBase64String(hashedPassword);
		}

		public static string GenerateSalt()
		{
			byte[] data = new byte[0x10];
			new RNGCryptoServiceProvider().GetBytes(data);
			return Convert.ToBase64String(data);
		}

		public static bool CheckPassword(string checkingPassword, string hashedPassword, string salt)
		{
			string hashedCheckingPassword = EncodePassword(checkingPassword, salt);
			return hashedPassword.Equals(hashedCheckingPassword);
		}
	}
}