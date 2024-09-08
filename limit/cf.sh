#!/bin/bash
MYIP=$(wget -qO- icanhazip.com);
apt install jq curl -y
clear
echo -e ""
echo -e "\033[96;1m============================\033[0m"
echo -e "\033[93;1m      INPUT SUBDOMAIN"
echo -e "\033[96;1m============================\033[0m"
echo -e "\033[91;1m Note. contoh Subdomain :\033[0m \033[93mbodoh22 \033[0m"
echo -e " "
read -p "SUBDOMAIN :  " domen
echo -e ""
#DOMAIN=ranstore.cloud
DOMAIN=ranstore.cloud
sub=${domen}
dns=${sub}.ranstore.cloud
#(</dev/urandom tr -dc a-z0-9 | head -c5)
#dns=${sub}.mypremium.biz.id
#CF_ID=andyyuda41@gmail.com
#CF_KEY=0d626234700bad388d6d07b49c42901445d1c
dns=${sub}.ranstore.cloud
CF_KEY=3b4e4274c71496bbbdf858f4c6800aa0380e0
CF_ID=Rantempest2@gmail.com
set -euo pipefail
IP=$(wget -qO- icanhazip.com);
echo "Updating DNS for ${dns}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${dns}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${dns}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${dns}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "$dns" > /root/domain
echo "$dns" > /root/scdomain
echo "$dns" > /etc/xray/domain
echo "$dns" > /etc/v2ray/domain
echo "$dns" > /etc/xray/scdomain
echo "IP=$dns" > /var/lib/kyt/ipvps.conf
cd

restart_system() {
USRSC=$(wget -qO- https://raw.githubusercontent.com/RanTempest/scvps/main/izin | grep $ipsaya | awk '{print $2}')
EXPSC=$(wget -qO- https://raw.githubusercontent.com/RanTempest/scvps/main/izin | grep $ipsaya | awk '{print $3}')
TIMEZONE=$(printf '%(%H:%M:%S)T')
TEXT="
<code>────────────────────</code>
<b> 🟢 NOTIFICATIONS INSTALL 🟢</b>
<code>────────────────────</code>
<code>ID     : </code><code>$USRSC</code>
<code>Domain : </code><code>$domain</code>
<code>Date   : </code><code>$TIME</code>
<code>Time   : </code><code>$TIMEZONE</code>
<code>Ip vps : </code><code>$ipsaya</code>
<code>Exp Sc : </code><code>$EXPSC</code>
<code>────────────────────</code>
<i>Automatic Notification from Github</i>
"'&reply_markup={"inline_keyboard":[[{"text":"ᴏʀᴅᴇʀ","url":"https://t.me/YuushaKanaeru"},{"text":"Contack","url":"https://wa.me/6283141751466"}]]}'"
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}

clear
