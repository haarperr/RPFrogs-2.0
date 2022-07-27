import discord
import requests
import random
import datetime
import string
import json
from io import BytesIO
import time
import os
import asyncio
import aiohttp
from dotenv import load_dotenv
import mysql.connector
from discord.ext import commands

load_dotenv()

color = discord.Colour(0x03bafc)
invites = {}
datetime = datetime.datetime.now()
data = {}
lockdown = False
try:
    with open('config.json') as f:
        data = json.load(f)
        configtoken = data["token"]
        configprefix = data["prefix"]
        fivem_server_ip_port = data["fivem_server_ip_port"]
        fivem_server_logo_url = data["fivem_server_logo_url"]
        server_name = data["server_name"]
        cfx_connect_url = data["cfx_connect_url"]
        embed_thumbnail = data["embed_thumbnail"]
        embed_footer = data["embed_footer"]
        moderation_logs = data["moderation_logs"]
        if moderation_logs:
            logs_channel = int(data["logs_channel"])
        welcome_message = data["welcome_message"]
        if welcome_message:
            welcome_channel = int(data["welcome_channel"])
        server_status_data = data["server_status_data"]
        if server_status_data:
            server_status_channel = int(data["server_status_channel"])
except:
    newdata = {}
    newdata["token"] = ""
    newdata["prefix"] = "!"
    newdata["fivem_server_ip_port"] = ""
    newdata["fivem_server_logo_url"] = ""
    newdata["server_name"] = ""
    newdata["cfx_connect_url"] = ""
    newdata["embed_thumbnail"] = ""
    newdata["embed_footer"] = ""
    newdata["moderation_logs"] = False
    newdata["logs_channel"] = ""
    newdata["welcome_message"] = False
    newdata["welcome_channel"] = ""
    newdata["server_status_data"] = False
    newdata["server_status_channel"] = ""

    with open('config.json', 'w') as outfile:
        json.dump(newdata, outfile, indent=2)

    with open('config.json') as f:
        data = json.load(f)
        configtoken = data["token"]
        configprefix = data["prefix"]
        fivem_server_ip_port = data["fivem_server_ip_port"]
        fivem_server_logo_url = data["fivem_server_logo_url"]
        server_name = data["server_name"]
        cfx_connect_url = data["cfx_connect_url"]
        embed_thumbnail = data["embed_thumbnail"]
        embed_footer = data["embed_footer"]
        moderation_logs = data["moderation_logs"]
        if moderation_logs:
            logs_channel = int(data["logs_channel"])
        welcome_message = data["welcome_message"]
        if welcome_message:
            welcome_channel = int(data["welcome_channel"])
        server_status_data = data["server_status_data"]
        if server_status_data:
            server_status_channel = int(data["server_status_channel"])

bot = commands.Bot(command_prefix = configprefix)
bot.remove_command('help')

embed_footer = f'{embed_footer} | Made by Vopori'
'''@bot.event
async def on_command_error(ctx, error):
    from discord.ext.commands import CommandNotFound
    from discord.ext.commands import MissingRequiredArgument
    from discord.ext.commands import BadArgument
    if isinstance(error, MissingRequiredArgument):
        await ctx.message.delete()
        await ctx.send('Missing required arguments.')
    elif isinstance(error, BadArgument):
        await ctx.message.delete()
        await ctx.send('Bad argument provided.')
    elif isinstance(error, commands.MissingPermissions):
        await ctx.message.delete()
        await ctx.send("You dont have permissions to perform this action.")
    elif isinstance(error, CommandNotFound):
        await ctx.message.delete()
        await ctx.send('I dont recognize that command.')
    else:
        print(error)'''

async def loop1():
    randomcolors = [0x03bafc, 0x16f7e8, 0x34f716, 0xff0800, 0xff0800, 0x8400ff, 0xff003c]
    if server_status_data:
        print('\x1b[32mSetting up bot....\x1b0m')
        fivem_status_channel = bot.get_channel(server_status_channel)
        await fivem_status_channel.purge(limit=200)
        altcolor = discord.Colour(random.choice(randomcolors))
        usernames = []
        try:
            res = requests.get(f'http://{fivem_server_ip_port}/dynamic.json')
            data = res.json()
            res3 = requests.get(f'http://{fivem_server_ip_port}/players.json')
            data3 = res3.json()
            for name in data3:
                usernames.append(name["name"])
            if len(str(data3)) > 3:
                usernames = '\n'.join('{}' for _ in range(len(usernames))).format(*usernames)
            if str(data3) == '[]':
                usernames = 'No players online'
            embed = discord.Embed(title=f'{server_name} is currently Online', color=altcolor)
            embed.add_field(name='How to join the server?', value=f'1. You can join the server using the F8 Console by typing `connect {cfx_connect_url}`\n2. Or just by searching `{server_name}` in the FiveM server list.', inline=False)
            embed.add_field(name='Server Status', value=':white_check_mark: Online')
            embed.add_field(name='Online Players', value=str(data["clients"]) + '/' + data["sv_maxclients"])
            embed.add_field(name='Player List', value=usernames, inline=False)
            embed.set_thumbnail(url=fivem_server_logo_url)
            embed.set_footer(text=embed_footer)
            message = await fivem_status_channel.send(embed=embed)
            os.system('cls')
            print('Bot is up')
        except:
            errorembed = discord.Embed(title=f'{server_name} is currently Offline', color=color)
            await fivem_status_channel.send(embed=errorembed)
            activity = discord.Game(name=f"Server Offline", type=3)
            await bot.change_presence(activity=activity)
            os.system('cls')
            print('Bot is up')
            print('Server is detected offline, for the live playercount to work you will have to restart the bot whenever the server is online.')
            return
        while True:
            altcolor = discord.Colour(random.choice(randomcolors))
            usernames = []
            res = requests.get(f'http://{fivem_server_ip_port}/dynamic.json')
            data = res.json()
            res3 = requests.get(f'http://{fivem_server_ip_port}/players.json')
            data3 = res3.json()
            playercount = str(data["clients"]) + '/' + str(data["sv_maxclients"])
            activity = discord.Activity(name=f"{playercount} Players", type=discord.ActivityType.watching)
            await bot.change_presence(activity=activity)
            for name in data3:
                usernames.append(name["name"])
            if len(str(data3)) > 3:
                usernames = '\n'.join('{}' for _ in range(len(usernames))).format(*usernames)
            if str(data3) == '[]':
                usernames = 'No players online'
            new_embed = discord.Embed(title=f'{server_name} is currently Online', color=altcolor,
            description=f'**How to join the server?**\n1. You can join the server using the F8 Console by typing `connect {cfx_connect_url}`\n2. Or just by searching `{server_name}` in the FiveM server list.')
            new_embed.add_field(name='\nServer Status', value=':white_check_mark: Online')
            new_embed.add_field(name='Online Players', value=str(data["clients"]) + '/' + data["sv_maxclients"])
            new_embed.add_field(name='\nPlayer List', value=usernames, inline=False)
            new_embed.set_thumbnail(url=fivem_server_logo_url)
            new_embed.set_footer(text=embed_footer)
            await message.edit(embed=new_embed)
            await asyncio.sleep(5)
    else:
        print(f'The bot is up in {len(bot.guilds)} server/s')

@bot.event
async def on_connect():
    for guild in bot.guilds:
        invites[guild.id] = await guild.invites()
    await loop1()

def find_invite_by_code(invite_list, code):
    for inv in invite_list:
        if inv.code == code:
            return inv

@bot.event
async def on_member_join(member):
    global lockdown 
    if lockdown == True:
        member.kick()
    if moderation_logs:
        members = sorted(member.guild.members, key=lambda m: m.joined_at)
        date_format = "%a, %d %b %Y %I:%M %p"
        embed = discord.Embed(title='User joined the guild', color=color, timestamp=datetime)
        embed.add_field(name='User', value=member.mention, inline=False)
        embed.add_field(name='User tag', value=member, inline=False)
        embed.add_field(name='User ID', value=member.id, inline=False)
        embed.add_field(name="Join position", value=str(members.index(member)+1), inline=False)
        embed.add_field(name="Joined at", value=member.joined_at.strftime(date_format), inline=False)
        embed.set_thumbnail(url=member.avatar_url)
        embed.set_footer(text=embed_footer)
        await bot.get_channel(logs_channel).send(embed=embed)
    invites_before_join = invites[member.guild.id]
    invites_after_join = await member.guild.invites()
    if welcome_message:
        for invite in invites_before_join:
            if invite.uses < find_invite_by_code(invites_after_join, invite.code).uses:
                invites[member.guild.id] = invites_after_join
                embed = discord.Embed(title='Welcome',
                description=f'Welcome to the Discord server, {member.mention}\n\nInvited by: {invite.inviter}',
                color=color, timestamp=datetime)
                embed.set_thumbnail(url=member.avatar_url)
                embed.set_footer(text=embed_footer)
                await bot.get_channel(welcome_channel).send(embed=embed)
                return
            else:
                embed = discord.Embed(title='Welcome',
                description=f'Welcome to the Discord server, {member.mention}\n\nInvited by: Uknown',
                color=color)
                embed.set_thumbnail(url=member.avatar_url)
                embed.set_footer(text=embed_footer)
                await bot.get_channel(welcome_channel).send(embed=embed)
                return

@bot.event
async def on_member_remove(member):
    if moderation_logs:
        members = sorted(member.guild.members, key=lambda m: m.joined_at)
        date_format = "%a, %d %b %Y %I:%M %p"
        embed = discord.Embed(title='User left the guild', color=color, timestamp=datetime)
        embed.add_field(name='User', value=member.mention, inline=False)
        embed.add_field(name='User tag', value=member, inline=False)
        embed.add_field(name="Joined at", value=member.joined_at.strftime(date_format), inline=False)
        embed.set_thumbnail(url=member.avatar_url)
        embed.set_footer(text=embed_footer)
        await bot.get_channel(logs_channel).send(embed=embed)
    
@bot.event
async def on_message_delete(ctx):
    if moderation_logs and not ctx.author.bot:
        embed = discord.Embed(title='Message Deleted', color=color, timestamp=datetime)
        embed.add_field(name='Message author', value=f'<@{ctx.author.id}>', inline=False)
        embed.add_field(name='Message author tag', value=ctx.author, inline=False)
        embed.add_field(name='Message author ID', value=ctx.author.id, inline=False)
        embed.add_field(name='Message content', value=ctx.content, inline=False)
        embed.set_footer(text=embed_footer)
        await bot.get_channel(logs_channel).send(embed=embed)

@bot.command(name='ping')
async def ping(ctx):
    await ctx.message.delete()
    await ctx.send(f'Pong! **{round(bot.latency * 1000)}ms**')



#Unbanning a member is done via typing ./unban and the ID of the banned member
@bot.command()
@commands.has_permissions(ban_members=True)   
async def unban(context, id : int):
       user = await bot.fetch_user(id)
       await context.guild.unban(user)
       await context.send(f'{user.name} has been unbanned')
    

@bot.command(name='help')
@commands.has_permissions(ban_members = True)
async def help(ctx):
    
    embed=discord.Embed(title="ChadBot - Helpful Commands", description="", color=0xfff700)
    embed.set_author(name="", url="https://www.twitch.tv/xqcow", icon_url="")
    embed.set_thumbnail(url="https://cdn.discordapp.com/attachments/961436816425246750/961841157057437696/download-removebg-preview.png")
    embed.add_field(name="!tempmute", value="Use followed by a time, then a reson. Temp mutes a user.", inline=False)
    embed.add_field(name="!ban", value="Bans specified user", inline=False)
    embed.add_field(name="!kick", value="Kicks specified user", inline=False)
    embed.add_field(name="!nuke", value="Nukes X amount of messages", inline=False)
    embed.add_field(name="!whois", value="Returns information about a user", inline=False)
    embed.add_field(name="!resetcid", value="Resets a players garage status by State ID", inline=False)
    embed.add_field(name="!resetpd", value="Resets all police vehicles", inline=False)
    embed.add_field(name="!resetall", value="Resets all garages", inline=False)
    embed.add_field(name="!chadsay", value="Say something as ChadBot", inline=False)
    embed.set_footer(text="<3 Vopori")
    await ctx.send(embed=embed)


@bot.command(name='chadsay')
@commands.has_permissions(administrator=True) 
async def hsay(ctx, *, text):
    await ctx.message.delete()
    await ctx.send(text)

banned_words = ["apple", "pear", "banana"]

@bot.event
async def on_message(message):
    # Make sure the Bot doesn't respond to it's own messages
    if message.author == bot.user: 
        return
    
    if message.content == 'cheat':
        await message.channel.send(f'Did someone say cheat <:forsencd:961722986690379836>')
    if message.content == 'bye':
        await message.channel.send(f'Goodbye {message.author}')

    await bot.process_commands(message)
    if any(word in message.content for word in banned_words):
        await message.delete()
        await message.channel.send('User tried to use banned phrase: {}'.format(message.author.mention))
   


load_dotenv()

@bot.command()
async def createemoji(ctx, url: str, *, name):
	guild = ctx.guild
	if ctx.author.guild_permissions.manage_emojis:
		async with aiohttp.ClientSession() as ses:
			async with ses.get(url) as r:
				
				try:
					img_or_gif = BytesIO(await r.read())
					b_value = img_or_gif.getvalue()
					if r.status in range(200, 299):
						emoji = await guild.create_custom_emoji(image=b_value, name=name)
						await ctx.send(f'Successfully created emoji: <:{name}:{emoji.id}>')
						await ses.close()
					else:
						await ctx.send(f'Error when making request | {r.status} response.')
						await ses.close()
						
				except discord.HTTPException:
					await ctx.send('File size is too big!')

@bot.command()
async def deleteemoji(ctx, emoji: discord.Emoji):
	guild = ctx.guild
	if ctx.author.guild_permissions.manage_emojis:
		await ctx.send(f'Successfully deleted (or not): {emoji}')
		await emoji.delete()










token = os.getenv("TOKEN")


@bot.command(name='ban')
@commands.has_permissions(ban_members = True)
async def ban(ctx, user: discord.Member=None, *, reason=None):
    if user == None:
        await ctx.send('You need to provide a user to ban.')
        return
    if reason == None:
        reason = 'N/A'
    await user.ban()
    message = f'You have been banned from {ctx.guild.name} for the following reason/s: {reason}'
    try:
        await user.send(message)
    except:
        print('Unable to send Ban DM')
        pass
    embed = discord.Embed(title='User Banned From RPFrogs', color=color, timestamp=datetime)
    embed.add_field(name='User Banned', value=user.mention)
    embed.add_field(name='Banned By', value=ctx.author.mention)
    embed.add_field(name='Reason', value=reason, inline=False)
    embed.set_thumbnail(url=embed_thumbnail)
    embed.set_footer(text=embed_footer)
    message = await ctx.channel.send(embed=embed)
    await asyncio.sleep(60)
    await message.delete()

@bot.command()
async def resetall(ctx):
    if ctx.author.guild_permissions.administrator:
        sql = mysql.connector.connect(
            host = "62.171.159.104",
            database = "gtav_rp3",
            user = "root",
            password = "643gw6543vw",
        )
        cursor = sql.cursor()
        cursor.execute("UPDATE characters_cars SET vehicle_state = 'In'")
        sql.commit()
        sql.close()
        await ctx.send("All vehicles have been reset!")
    else:
        await ctx.send("You do not have permission to use this command!")
        
@bot.command()
@commands.cooldown(1, 14400, commands.BucketType.user)
async def resetcid(ctx, cid):
    sql = mysql.connector.connect(
            host = "62.171.159.104",
            database = "gtav_rp3",
            user = "root",
            password = "643gw6543vw",
        )
    cursor = sql.cursor()
    cursor.execute("UPDATE characters_cars SET vehicle_state = 'In' WHERE cid = %s AND NOT current_garage = %s", (cid,'nomalimpound'))
    sql.commit()
    sql.close()
    await ctx.send("All vehicles have been reset for this character with the State ID of " + cid + "!")

@bot.command()
@commands.cooldown(1, 14400, commands.BucketType.user)
async def resetpd(ctx):
    sql = mysql.connector.connect(
            host = "62.171.159.104",
            database = "gtav_rp3",
            user = "root",
            password = "643gw6543vw",
        )
    cursor = sql.cursor()
    cursor.execute("UPDATE characters_cars SET vehicle_state = 'In' WHERE garage_info = %s", ("law",))
    sql.commit()
    sql.close()
    await ctx.send("All PD vehicles have been reset!")

@bot.event
async def on_command_error(ctx, error):
    if isinstance(error, commands.CommandOnCooldown):
        await ctx.send('You have just used this command - please wait and try again.')


@bot.command(name='kick')
@commands.has_permissions(kick_members = True)
async def kick(ctx, user: discord.Member=None, *, reason=None):
    if user == None:
        await ctx.send('You need to provide a user to kick.')
        return
    if reason == None:
        reason = 'N/A'
    await user.kick()
    message = f'You have been kicked from {ctx.guild.name} for the following reason/s: {reason}'
    embed = discord.Embed(title='User Kicked From RPFrogs', color=color, timestamp=datetime)
    embed.add_field(name='User Kicked', value=user.mention)
    embed.add_field(name='Kicked By', value=ctx.author.mention)
    embed.set_thumbnail(url=embed_thumbnail)
    embed.set_footer(text=embed_footer)
    message = await ctx.send(embed=embed)
    await asyncio.sleep(60)
    await message.delete()


@bot.command(name='pull')
async def pull(ctx):
    # execute "git pull" in the terminal in /home/RP-Frogs/
    # this will pull the latest changes from the repo xqcL
    stream =os.popen("cd /home/RPFrogs/ && git pull")
    await ctx.send(stream.read())
    
    

@bot.command(name='nuke')
@commands.has_permissions(manage_messages = True)
async def nuke(ctx, amount:int):
    await ctx.message.delete()
    await ctx.channel.purge(limit=amount)
    embed = discord.Embed(title='Channel Nuked!', description=f'{amount} messages have been deleted from this channel.', color=color)
    embed.add_field(name='Nuked By', value=f'<@{ctx.author.id}>')
    embed.set_footer(text=embed_footer)
    message = await ctx.channel.send(embed=embed)
    await asyncio.sleep(60)
    await message.delete()

@bot.command(aliases=['tempmute'])
@commands.has_permissions(manage_messages=True)
async def mute(ctx, member: discord.Member=None, time=None, *, reason=None):
    if not member:
        await ctx.send("You must mention a member to mute!")
        return
    elif not time:
        await ctx.send("You must mention a time!")
        return
    else:
        if not reason:
            reason="No reason given"
        #Now timed mute manipulation
    try:
        time_interval = time[:-1] #Gets the numbers from the time argument, start to -1
        duration = time[-1] #Gets the timed manipulation, s, m, h, d
        if duration == "s":
            time_interval = time_interval * 1
        elif duration == "m":
            time_interval = time_interval * 60
        elif duration == "h":
            time_interval = time_interval * 60 * 60
        elif duration == "d":
            time_interval = time_interval * 86400
        else:
            await ctx.send("Invalid duration input")
            return
    except Exception as e:
        print(e)
        await ctx.send("Invalid time input")
        return
    guild = ctx.guild
    Muted = discord.utils.get(guild.roles, name="Muted")
    if not Muted:
        Muted = await guild.create_role(name="Muted")
        for channel in guild.channels:
            await channel.set_permissions(Muted, speak=False, send_messages=False, read_message_history=True, read_messages=False)
    else:
        await member.add_roles(Muted, reason=reason)
        muted_embed = discord.Embed(title="Muted User", description=f"{member.mention} wasas muted by {ctx.author.mention} for {reason} - The mute will expire in {time}")
        await ctx.send(embed=muted_embed)
        await asyncio.sleep(int(time_interval))
        await member.remove_roles(Muted)
        unmute_embed = discord.Embed(title='Mute Expired', description=f'{ctx.author.mention} muted to {member.mention} for {reason} is over after {time}')
        await ctx.send(embed=unmute_embed)

@bot.command(aliases=["whois"])
async def userinfo(ctx, member: discord.Member = None):
    if not member:  # if member is no mentioned
        member = ctx.message.author  # set member as the author
    roles = [role for role in member.roles]
    embed = discord.Embed(colour=discord.Colour.purple(), timestamp=ctx.message.created_at,
                          title=f"User Info - {member}")
    embed.set_thumbnail(url=member.avatar_url)
    embed.set_footer(text=f"Requested by {ctx.author}")

    embed.add_field(name="ID:", value=member.id)
    embed.add_field(name="Display Name:", value=member.display_name)

    embed.add_field(name="Created Account On:", value=member.created_at.strftime("%a, %#d %B %Y, %I:%M %p UTC"))
    embed.add_field(name="Joined Server On:", value=member.joined_at.strftime("%a, %#d %B %Y, %I:%M %p UTC"))

    embed.add_field(name="Roles:", value="".join([role.mention for role in roles]))
    embed.add_field(name="Highest Role:", value=member.top_role.mention)
    print(member.top_role.mention)
    await ctx.send(embed=embed)

@bot.command()
@commands.has_permissions(manage_messages = True)
async def serverinfo(ctx):
    await ctx.message.delete()
    icon_url = ctx.guild.icon_url
    embed = discord.Embed(color=color, timestamp=datetime)
    embed.set_author(name=ctx.guild.name, icon_url=icon_url)
    embed.add_field(name='Owner', value=ctx.guild.owner)
    embed.add_field(name='Region', value=ctx.guild.region)
    embed.add_field(name='Channel Categories', value=len(ctx.guild.categories))
    embed.add_field(name='Text Channels', value=len(ctx.guild.text_channels))
    embed.add_field(name='Voice Channels', value=len(ctx.guild.voice_channels))
    embed.add_field(name='Members', value=len(ctx.guild.members))
    embed.add_field(name='Roles', value=len(ctx.guild.roles))
    embed.set_footer(text=embed_footer)
    message = await ctx.channel.send(embed=embed)
    await asyncio.sleep(60)
    await message.delete()

@bot.command()
@commands.has_permissions(administrator = True)
async def lockdown(ctx, choice):
    await ctx.message.delete()
    global lockdown
    if choice.lower() == 'on':
        noembed = discord.Embed(title='Server lockdown', description='The server is now in lockdown, anyone that joins the server from now on will be kicked.', color=color, timestamp=datetime)
        noembed.set_footer(text=embed_footer)
        await ctx.send(embed=noembed)
        lockdown = False
    if choice.lower() == 'off':
        noembed = discord.Embed(title='Server lockdown', description='The server is no longer on lockdown, no one will be kicked when joining anymore.', color=color, timestamp=datetime)
        noembed.set_footer(text=embed_footer)
        await ctx.send(embed=noembed)
        lockdown = True
    
try:
    bot.run(configtoken)
except:
    print('The bot token is either none or invalid, please enter a token in the config.json')

