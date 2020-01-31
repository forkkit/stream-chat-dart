import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:stream_chat/src/models/channel_state.dart';
import 'package:stream_chat/src/models/channel_config.dart';
import 'package:stream_chat/src/models/message.dart';
import 'package:stream_chat/src/models/command.dart';
import 'package:stream_chat/src/models/user.dart';

void main() {
  group('src/models/channel_state', () {
    const jsonExample = r'''{
   "channel": {
     "id": "dev",
     "type": "team",
     "cid": "team:dev",
     "last_message_at": "2020-01-30T13:43:41.062362Z",
     "created_at": "2019-04-03T18:43:33.213373Z",
     "updated_at": "2019-04-03T18:43:33.213374Z",
     "created_by": {
       "id": "guido",
       "role": "user",
       "created_at": "2019-04-03T18:43:33.201036Z",
       "updated_at": "2019-04-03T18:43:33.204713Z",
       "banned": false,
       "online": false,
       "name": "Guido"
     },
     "frozen": true,
     "config": {
       "created_at": "2019-11-07T22:29:26.776526Z",
       "updated_at": "2019-11-07T22:29:48.286746Z",
       "name": "team",
       "typing_events": true,
       "read_events": true,
       "connect_events": true,
       "search": true,
       "reactions": true,
       "replies": true,
       "mutes": true,
       "uploads": true,
       "url_enrichment": true,
       "message_retention": "infinite",
       "max_message_length": 5000,
       "automod": "disabled",
       "automod_behavior": "flag",
       "commands": [
         {
           "name": "giphy",
           "description": "Post a random gif to the channel",
           "args": "[text]",
           "set": "fun_set"
         }
       ]
     },
     "name": "#dev",
     "image": "https://cdn.chrisshort.net/testing-certificate-chains-in-go/GOPHER_MIC_DROP.png",
     "example": 1
   },
   "messages": [
     {
       "id": "dry-meadow-0-2b73cc8b-cd86-4a01-8d40-bd82ad07a030",
       "text": "fasdfa",
       "html": "<p>fasdfa</p>\n",
       "type": "regular",
       "user": {
         "id": "dry-meadow-0",
         "role": "user",
         "created_at": "2019-03-27T17:40:17.155892Z",
         "updated_at": "2020-01-29T03:22:47.641589Z",
         "last_active": "2020-01-29T03:22:47.63613Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Dry+meadow",
         "name": "Dry meadow"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T03:23:02.843948Z",
       "updated_at": "2020-01-29T03:23:02.843949Z",
       "mentioned_users": []
     },
     {
       "id": "dry-meadow-0-e8e74482-b4cd-48db-9d1e-30e6c191786f",
       "text": "test message",
       "html": "<p>test message</p>\n",
       "type": "regular",
       "user": {
         "id": "dry-meadow-0",
         "role": "user",
         "created_at": "2019-03-27T17:40:17.155892Z",
         "updated_at": "2020-01-29T03:22:47.641589Z",
         "last_active": "2020-01-29T03:22:47.63613Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Dry+meadow",
         "name": "Dry meadow"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T03:23:07.981091Z",
       "updated_at": "2020-01-29T03:23:07.981091Z",
       "mentioned_users": []
     },
     {
       "id": "dry-meadow-0-53e6299f-9b97-4a9c-a27e-7e2dde49b7e0",
       "text": "test message",
       "html": "<p>test message</p>\n",
       "type": "regular",
       "user": {
         "id": "dry-meadow-0",
         "role": "user",
         "created_at": "2019-03-27T17:40:17.155892Z",
         "updated_at": "2020-01-29T03:22:47.641589Z",
         "last_active": "2020-01-29T03:22:47.63613Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Dry+meadow",
         "name": "Dry meadow"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T03:23:11.568022Z",
       "updated_at": "2020-01-29T03:23:11.568022Z",
       "mentioned_users": []
     },
     {
       "id": "dry-meadow-0-80925be0-786e-40a5-b225-486518dafd35",
       "text": "asdfadf",
       "html": "<p>asdfadf</p>\n",
       "type": "regular",
       "user": {
         "id": "dry-meadow-0",
         "role": "user",
         "created_at": "2019-03-27T17:40:17.155892Z",
         "updated_at": "2020-01-29T03:22:47.641589Z",
         "last_active": "2020-01-29T03:22:47.63613Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Dry+meadow",
         "name": "Dry meadow"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T03:32:57.403566Z",
       "updated_at": "2020-01-29T03:32:57.403566Z",
       "mentioned_users": []
     },
     {
       "id": "dry-meadow-0-64d7970f-ede8-4b31-9738-1bc1756d2bfe",
       "text": "test",
       "html": "<p>test</p>\n",
       "type": "regular",
       "user": {
         "id": "dry-meadow-0",
         "role": "user",
         "created_at": "2019-03-27T17:40:17.155892Z",
         "updated_at": "2020-01-29T03:22:47.641589Z",
         "last_active": "2020-01-29T03:22:47.63613Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Dry+meadow",
         "name": "Dry meadow"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T03:33:35.294802Z",
       "updated_at": "2020-01-29T03:33:35.294802Z",
       "mentioned_users": []
     },
     {
       "id": "withered-cell-0-84cbd760-cf55-4f7e-9207-c5f66cccc6dc",
       "text": "hi",
       "html": "<p>hi</p>\n",
       "type": "regular",
       "user": {
         "id": "withered-cell-0",
         "role": "user",
         "created_at": "2020-01-29T03:34:01.698106Z",
         "updated_at": "2020-01-29T03:34:01.708808Z",
         "last_active": "2020-01-29T03:34:01.70353Z",
         "banned": false,
         "online": false,
         "name": "Withered cell",
         "image": "https://getstream.io/random_svg/?name=Withered+cell"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T03:34:27.393296Z",
       "updated_at": "2020-01-29T03:34:27.393296Z",
       "mentioned_users": []
     },
     {
       "id": "dry-meadow-0-e9203588-43c3-40b1-91f7-f217fc42aa53",
       "text": "fantastic",
       "html": "<p>fantastic</p>\n",
       "type": "regular",
       "user": {
         "id": "dry-meadow-0",
         "role": "user",
         "created_at": "2019-03-27T17:40:17.155892Z",
         "updated_at": "2020-01-29T03:22:47.641589Z",
         "last_active": "2020-01-29T03:22:47.63613Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Dry+meadow",
         "name": "Dry meadow"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T03:34:37.638376Z",
       "updated_at": "2020-01-29T03:34:37.638376Z",
       "mentioned_users": []
     },
     {
       "id": "withered-cell-0-7e3552d7-7a0d-45f2-a856-e91b23a7e240",
       "text": "nice to meet you",
       "html": "<p>nice to meet you</p>\n",
       "type": "regular",
       "user": {
         "id": "withered-cell-0",
         "role": "user",
         "created_at": "2020-01-29T03:34:01.698106Z",
         "updated_at": "2020-01-29T03:34:01.708808Z",
         "last_active": "2020-01-29T03:34:01.70353Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Withered+cell",
         "name": "Withered cell"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T03:35:04.301566Z",
       "updated_at": "2020-01-29T03:35:04.301566Z",
       "mentioned_users": []
     },
     {
       "id": "dry-meadow-0-1ffeafd4-e4fc-4c84-9394-9d7cb10fff42",
       "text": "hey",
       "html": "<p>hey</p>\n",
       "type": "regular",
       "user": {
         "id": "dry-meadow-0",
         "role": "user",
         "created_at": "2019-03-27T17:40:17.155892Z",
         "updated_at": "2020-01-29T03:22:47.641589Z",
         "last_active": "2020-01-29T03:22:47.63613Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Dry+meadow",
         "name": "Dry meadow"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T03:35:24.939084Z",
       "updated_at": "2020-01-29T03:35:24.939085Z",
       "mentioned_users": []
     },
     {
       "id": "dry-meadow-0-3f147324-12c8-4b41-9fb5-2db88d065efa",
       "text": "hello, everyone",
       "html": "<p>hello, everyone</p>\n",
       "type": "regular",
       "user": {
         "id": "dry-meadow-0",
         "role": "user",
         "created_at": "2019-03-27T17:40:17.155892Z",
         "updated_at": "2020-01-29T03:22:47.641589Z",
         "last_active": "2020-01-29T03:22:47.63613Z",
         "banned": false,
         "online": false,
         "name": "Dry meadow",
         "image": "https://getstream.io/random_svg/?name=Dry+meadow"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T03:35:33.101566Z",
       "updated_at": "2020-01-29T03:35:33.101566Z",
       "mentioned_users": []
     },
     {
       "id": "dry-meadow-0-51a348ae-0c0a-44de-a556-eac7891c0cf0",
       "text": "who is there?",
       "html": "<p>who is there?</p>\n",
       "type": "regular",
       "user": {
         "id": "dry-meadow-0",
         "role": "user",
         "created_at": "2019-03-27T17:40:17.155892Z",
         "updated_at": "2020-01-29T03:22:47.641589Z",
         "last_active": "2020-01-29T03:22:47.63613Z",
         "banned": false,
         "online": false,
         "name": "Dry meadow",
         "image": "https://getstream.io/random_svg/?name=Dry+meadow"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T03:35:45.458685Z",
       "updated_at": "2020-01-29T03:35:45.458685Z",
       "mentioned_users": []
     },
     {
       "id": "icy-recipe-7-a29e237b-8d81-4a97-9bc8-d42bca3f1356",
       "text": "하이",
       "html": "<p>하이</p>\n",
       "type": "regular",
       "user": {
         "id": "icy-recipe-7",
         "role": "user",
         "created_at": "2020-01-21T11:36:22.284503Z",
         "updated_at": "2020-01-29T07:01:59.69882Z",
         "last_active": "2020-01-29T07:01:59.693378Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Icy+recipe",
         "name": "Icy recipe"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T07:02:11.535395Z",
       "updated_at": "2020-01-29T07:02:11.535395Z",
       "mentioned_users": []
     },
     {
       "id": "icy-recipe-7-935c396e-ddf8-4a9a-951c-0a12fa5bf055",
       "text": "what are you doing?",
       "html": "<p>what are you doing?</p>\n",
       "type": "regular",
       "user": {
         "id": "icy-recipe-7",
         "role": "user",
         "created_at": "2020-01-21T11:36:22.284503Z",
         "updated_at": "2020-01-29T07:01:59.69882Z",
         "last_active": "2020-01-29T07:01:59.693378Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Icy+recipe",
         "name": "Icy recipe"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T07:02:22.485136Z",
       "updated_at": "2020-01-29T07:02:22.485136Z",
       "mentioned_users": []
     },
     {
       "id": "throbbing-boat-5-1e4d5730-5ff0-4d25-9948-9f34ffda43e4",
       "text": "👍",
       "html": "<p>👍</p>\n",
       "type": "regular",
       "user": {
         "id": "throbbing-boat-5",
         "role": "user",
         "created_at": "2019-07-30T06:29:53.060413Z",
         "updated_at": "2020-01-29T14:11:27.80176Z",
         "last_active": "2020-01-29T14:11:27.7963Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Throbbing+boat",
         "name": "Throbbing boat"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T14:12:04.688552Z",
       "updated_at": "2020-01-29T14:12:04.688552Z",
       "mentioned_users": []
     },
     {
       "id": "snowy-credit-3-3e0c1a0d-d22f-42ee-b2a1-f9f49477bf21",
       "text": "sdasas",
       "html": "<p>sdasas</p>\n",
       "type": "regular",
       "user": {
         "id": "snowy-credit-3",
         "role": "user",
         "created_at": "2020-01-29T15:29:03.693312Z",
         "updated_at": "2020-01-29T15:29:03.702648Z",
         "last_active": "2020-01-29T15:29:03.696144Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Snowy+credit",
         "name": "Snowy credit"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T15:29:36.011315Z",
       "updated_at": "2020-01-29T15:29:36.011316Z",
       "mentioned_users": []
     },
     {
       "id": "snowy-credit-3-3319537e-2d0e-4876-8170-a54f046e4b7d",
       "text": "cjshsa",
       "html": "<p>cjshsa</p>\n",
       "type": "regular",
       "user": {
         "id": "snowy-credit-3",
         "role": "user",
         "created_at": "2020-01-29T15:29:03.693312Z",
         "updated_at": "2020-01-29T15:29:03.702648Z",
         "last_active": "2020-01-29T15:29:03.696144Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Snowy+credit",
         "name": "Snowy credit"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T15:29:41.677819Z",
       "updated_at": "2020-01-29T15:29:41.677819Z",
       "mentioned_users": []
     },
     {
       "id": "snowy-credit-3-cfaf0b46-1daa-49c5-947c-b16d6697487d",
       "text": "nhisagdhsadz",
       "html": "<p>nhisagdhsadz</p>\n",
       "type": "regular",
       "user": {
         "id": "snowy-credit-3",
         "role": "user",
         "created_at": "2020-01-29T15:29:03.693312Z",
         "updated_at": "2020-01-29T15:29:03.702648Z",
         "last_active": "2020-01-29T15:29:03.696144Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Snowy+credit",
         "name": "Snowy credit"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T15:29:43.354177Z",
       "updated_at": "2020-01-29T15:29:43.354177Z",
       "mentioned_users": []
     },
     {
       "id": "snowy-credit-3-cebe25a7-a3a3-49fc-9919-91c6725e81f3",
       "text": "hvadhsahzd",
       "html": "<p>hvadhsahzd</p>\n",
       "type": "regular",
       "user": {
         "id": "snowy-credit-3",
         "role": "user",
         "created_at": "2020-01-29T15:29:03.693312Z",
         "updated_at": "2020-01-29T15:29:03.702648Z",
         "last_active": "2020-01-29T15:29:03.696144Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Snowy+credit",
         "name": "Snowy credit"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T15:29:44.754713Z",
       "updated_at": "2020-01-29T15:29:44.754713Z",
       "mentioned_users": []
     },
     {
       "id": "divine-glade-9-0cea9262-5766-48e9-8b22-311870aed3bf",
       "text": "hello",
       "html": "<p>hello</p>\n",
       "type": "regular",
       "user": {
         "id": "divine-glade-9",
         "role": "user",
         "created_at": "2020-01-29T17:02:18.312524Z",
         "updated_at": "2020-01-29T17:02:18.320187Z",
         "last_active": "2020-01-29T17:02:18.315074Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Divine+glade",
         "name": "Divine glade"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T17:02:36.933852Z",
       "updated_at": "2020-01-29T17:02:36.933852Z",
       "mentioned_users": []
     },
     {
       "id": "red-firefly-9-c4e9007b-bb7d-4238-ae08-5f8e3cd03d73",
       "text": "hello",
       "html": "<p>hello</p>\n",
       "type": "regular",
       "user": {
         "id": "red-firefly-9",
         "role": "user",
         "created_at": "2019-08-02T18:56:39.366516Z",
         "updated_at": "2020-01-29T22:13:50.491769Z",
         "last_active": "2020-01-29T22:13:50.450215Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Red+firefly",
         "name": "Red firefly"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-29T22:14:08.54062Z",
       "updated_at": "2020-01-29T22:14:08.54062Z",
       "mentioned_users": []
     },
     {
       "id": "bitter-glade-2-02aee4eb-4093-4736-808b-2de75820e854",
       "text": "hello",
       "html": "<p>hello</p>\n",
       "type": "regular",
       "user": {
         "id": "bitter-glade-2",
         "role": "user",
         "created_at": "2020-01-30T13:08:56.190678Z",
         "updated_at": "2020-01-30T13:08:56.200333Z",
         "last_active": "2020-01-30T13:08:56.193882Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Bitter+glade",
         "name": "Bitter glade"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-30T13:11:37.191293Z",
       "updated_at": "2020-01-30T13:11:37.191293Z",
       "mentioned_users": []
     },
     {
       "id": "morning-sea-1-0c700bcb-46dd-4224-b590-e77bdbccc480",
       "text": "http://jaeger.ui.gtstrm.com/",
       "html": "<p><a href=\"http://jaeger.ui.gtstrm.com/\" rel=\"nofollow\">http://jaeger.ui.gtstrm.com/</a></p>\n",
       "type": "regular",
       "user": {
         "id": "morning-sea-1",
         "role": "user",
         "created_at": "2019-07-22T09:19:07.505207Z",
         "updated_at": "2020-01-30T13:33:05.831856Z",
         "last_active": "2020-01-30T13:33:05.825369Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Morning+sea",
         "name": "Morning sea"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-30T13:33:16.853116Z",
       "updated_at": "2020-01-30T13:33:16.853116Z",
       "mentioned_users": []
     },
     {
       "id": "ancient-salad-0-53e8b4e6-5b7b-43ad-aeee-8bfb6a9ed0be",
       "text": "hi",
       "html": "<p>hi</p>\n",
       "type": "regular",
       "user": {
         "id": "ancient-salad-0",
         "role": "user",
         "created_at": "2020-01-30T13:34:29.286813Z",
         "updated_at": "2020-01-30T13:34:29.296196Z",
         "last_active": "2020-01-30T13:34:29.289964Z",
         "banned": false,
         "online": true,
         "image": "https://getstream.io/random_svg/?name=Ancient+salad",
         "name": "Ancient salad"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-30T13:36:52.749731Z",
       "updated_at": "2020-01-30T13:36:52.749732Z",
       "mentioned_users": []
     },
     {
       "id": "ancient-salad-0-8c225075-bd4c-42e2-8024-530aae13cd40",
       "text": "hi",
       "html": "<p>hi</p>\n",
       "type": "regular",
       "user": {
         "id": "ancient-salad-0",
         "role": "user",
         "created_at": "2020-01-30T13:34:29.286813Z",
         "updated_at": "2020-01-30T13:34:29.296196Z",
         "last_active": "2020-01-30T13:34:29.289964Z",
         "banned": false,
         "online": true,
         "image": "https://getstream.io/random_svg/?name=Ancient+salad",
         "name": "Ancient salad"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-30T13:37:41.631056Z",
       "updated_at": "2020-01-30T13:37:41.631056Z",
       "mentioned_users": []
     },
     {
       "id": "proud-sea-7-17802096-cbf8-4e3c-addd-4ee31f4c8b5c",
       "text": "😃",
       "html": "<p>😃</p>\n",
       "type": "regular",
       "user": {
         "id": "proud-sea-7",
         "role": "user",
         "created_at": "2020-01-30T13:43:03.903006Z",
         "updated_at": "2020-01-30T13:43:03.912307Z",
         "last_active": "2020-01-30T13:43:03.906236Z",
         "banned": false,
         "online": false,
         "image": "https://getstream.io/random_svg/?name=Proud+sea",
         "name": "Proud sea"
       },
       "attachments": [],
       "latest_reactions": [],
       "own_reactions": [],
       "reaction_counts": {},
       "reaction_scores": {},
       "reply_count": 0,
       "created_at": "2020-01-30T13:43:41.062362Z",
       "updated_at": "2020-01-30T13:43:41.062362Z",
       "mentioned_users": []
     }
   ],
   "watcher_count": 5,
   "members": []
 }''';

    test('should parse json correctly', () {
      final channelState = ChannelState.fromJson(json.decode(jsonExample));
      expect(channelState.channel.cid, 'team:dev');
      expect(channelState.channel.id, 'dev');
      expect(channelState.channel.type, 'team');
      expect(channelState.channel.config, isA<ChannelConfig>());
      expect(channelState.channel.config, isNotNull);
      expect(channelState.channel.config.commands, hasLength(1));
      expect(channelState.channel.config.commands[0], isA<Command>());
      expect(channelState.channel.lastMessageAt,
          DateTime.parse("2020-01-30T13:43:41.062362Z"));
      expect(channelState.channel.createdAt,
          DateTime.parse("2019-04-03T18:43:33.213373Z"));
      expect(channelState.channel.updatedAt,
          DateTime.parse("2019-04-03T18:43:33.213374Z"));
      expect(channelState.channel.createdBy, isA<User>());
      expect(channelState.channel.frozen, true);
      expect(channelState.channel.extraData['example'], 1);
      expect(channelState.channel.extraData['name'], "#dev");
      expect(channelState.channel.extraData['image'],
          "https://cdn.chrisshort.net/testing-certificate-chains-in-go/GOPHER_MIC_DROP.png");
      expect(channelState.messages, hasLength(25));
      expect(channelState.messages[0], isA<Message>());
      expect(channelState.messages[0], isNotNull);
      expect(channelState.messages[0].createdAt,
          DateTime.parse("2020-01-29T03:23:02.843948Z"));
      expect(channelState.messages[0].user, isA<User>());
      expect(channelState.watcherCount, 5);
    });
  });
}
