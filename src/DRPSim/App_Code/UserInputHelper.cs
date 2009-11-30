namespace DRPSim
{
	public static class UserInputHelper
	{
		public static string GenerateSummary(string text)
		{
			if(text.Length > 100)
			{
				return text.Substring(0, 97) + "...";
			}

			return text;
		}
	}
}