import discord
from discord.ext import commands
TOKEN = 'NTkxNzQ5MzEyMjk2Mzg2NTcw.Ydr1GQ.xHHS7HmfGK-98x-g0W0-RF-pPUY'
PREFIX = '!'
INTENTS = discord.Intents.default()
bot = commands.Bot(command_prefix=PREFIX, intents=INTENTS)


@bot.event
async def on_ready():
    print(f'Logged in as: {bot.user.name}')
    print(f'With ID: {bot.user.id}')


@bot.command()
async def ping(ctx):
    await ctx.send('pong')


bot.run(TOKEN)