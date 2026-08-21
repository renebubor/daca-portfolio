from supabase import create_client

# Asenda oma Supabase andmetega (Connect > API Keys)
url = "https://qirlefyrafbhdcipcans.supabase.co"
key = "sb_publishable_PEY7f-sAatkL2dgHSIRuag_f3d0Cf3A"

supabase = create_client(url, key)

# Asenda oma tabeli nimega (nt 'test_sales' või 'team_members')
response = supabase.table('team_members').select("*").execute()

print(f"Leitud ridu: {len(response.data)}")
for row in response.data:
    print(row)
