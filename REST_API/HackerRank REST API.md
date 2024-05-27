![[Pasted image 20240527124739.png]]

```python
def getTotalGoals(team, year):
    # Write your code here
    base_url = "https://jsonmock.hackerrank.com/api/football_matches?"
    
    def fetch_all_pages(url):
        response = requests.get(url).json()
        total_pages = response['total_pages']
        all_data = response['data']
        
        for page in range(2, total_pages + 1):
            response = requests.get(f"{url}&page={page}").json()
            all_data.extend(response['data'])
        
        return all_data
    
    team1Url = f"{base_url}year={year}&team1={team}"
    team2Url = f"{base_url}year={year}&team2={team}"
    
    team1Data = fetch_all_pages(team1Url)
    team2Data = fetch_all_pages(team2Url)

    goals = 0
    for data in team1Data:
        goals += int(data['team1goals'])
    for data in team2Data:
        goals += int(data['team2goals'])
    return goals
```

![[Pasted image 20240527124848.png]]

```python
import requests

def getWinnerTotalGoals(competition, year):
    # Fetch the winner team
    competition_url = f"https://jsonmock.hackerrank.com/api/football_competitions?name={competition}&year={year}"
    response = requests.get(competition_url).json()
    if response['data']:
        winning_team = response['data'][0]['winner']
    else:
        return 0

    def getTotalGoals(competition, team, year):
        base_url = "https://jsonmock.hackerrank.com/api/football_matches?"
    
        def fetch_all_pages(url):
            response = requests.get(url).json()
            total_pages = response['total_pages']
            all_data = response['data']
            
            for page in range(2, total_pages + 1):
                response = requests.get(f"{url}&page={page}").json()
                all_data.extend(response['data'])
            
            return all_data
        
        team1_url = f"{base_url}competition={competition}&year={year}&team1={team}"
        team2_url = f"{base_url}competition={competition}&year={year}&team2={team}"
        
        team1_data = fetch_all_pages(team1_url)
        team2_data = fetch_all_pages(team2_url)
        
        goals = 0
        for data in team1_data:
            if data['competition'] == competition:
                goals += int(data['team1goals'])
        for data in team2_data:
            if data['competition'] == competition:
                goals += int(data['team2goals'])
        return goals
    
    all_goals = getTotalGoals(competition, winning_team, year)
    return all_goals

# Example usage:
print(getWinnerTotalGoals("UEFA Champions League", 2011))  # Expected output: 28
```