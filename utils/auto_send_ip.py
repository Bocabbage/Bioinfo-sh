#! /usr/bin/env python
# Update date: 2020/09/14
# Author: Zhuofan Zhang
from email.mime.text import MIMEText
from email.header import Header
import smtplib
import time
import socket
import argparse

def autoSendIp(sendEmail, sendEmailPassword, dstEmail, ipCache):
    ''' 
        Send the IP to dst-EMAIL if changed.
    '''
    newIP = IPchangeCheck(ipCache)
    if newIP is not None:
        sendIpEmail(sendEmail, sendEmailPassword, dstEmail, newIP)


def sendIpEmail(sendEmail, sendQQAuthorization, dstEmail, newIP):
    '''
        build and send the E-MAIL including the new IP-address.
        use QQ SMTP to help to send the mail.
    '''
    mailHost = "smtp.qq.com"

    msg = MIMEText('new IP:{}'.format(newIP), 'plain', 'utf-8')
    msg['From'] = Header('zfzhang', 'utf-8')
    msg['To'] = Header('zfzhang97', 'utf-8')
    msg['Subject'] = "New ip: {}".format(time.asctime(time.localtime(time.time())))

    try:
        smtpObj = smtplib.SMTP_SSL(mailHost, smtplib.SMTP_SSL_PORT)
        smtpObj.login(sendEmail, sendQQAuthorization)
        smtpObj.sendmail(sendEmail, dstEmail, msg.as_string())
        print("Email sending success.")
    except smtplib.SMTPException:
        print("Email sending failed.")


def getNowIP():
    '''
        return the LAN ip of the host.
        method: use UDP protocol to get the IP address
    '''
    # family: AF_INET    -- communicate between hosts
    # type  : SOCK_DGRAM -- UDP protocol
    sockObj = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    # pretend to ask sth and get IP from the header of the UDP package
    sockObj.connect(('8.8.8.8', 80))
    ip = sockObj.getsockname()[0]
    sockObj.close()

    return ip


def IPchangeCheck(ipCache):
    '''
        check if the IP changed since the last caching time.
    '''
    with open(ipCache, 'r') as cacheFile:
        oldIP = cacheFile.readline().strip()

    newIP = getNowIP()
    if newIP != oldIP:
        with open(ipCache, 'w') as cacheFile:
            cacheFile.write(newIP)
        return newIP

    return None

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--sender', type=str)
    parser.add_argument('--authorization', type=str)
    parser.add_argument('--receiver', type=str)
    parser.add_argument('--cache', type=str)
    args = parser.parse_args()
    autoSendIp(args.sender, args.authorization, args.receiver, args.cache)
    
