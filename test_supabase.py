from supabase import create_client, Client

# Asenda oma andmetega (leiad Connect > API Keys modaalist)
url = "https://qirlefyrafbhdcipcans.supabase.co"
key = "sb_publishable_PEY7f-sAatkL2dgHSIRuag_f3d0Cf3A"

supabase: Client = create_client(url, key)

# Testi päring
response = supabase.table('test_sales').select("*").execute()

print("Ühendus edukas! Leitud ridu:", len(response.data))
print(response.data)
