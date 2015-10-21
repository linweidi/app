//
// Copyright (c) 2015 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


//-----------------------------------------------------------------------
//---------------------------   APP CONFIG    --------------------------------------
//-----------------------------------------------------------------------

#define     DEBUG_MODE                          1
#define     PARSE_MODE                          2
#define     SERVER_MODE                         3
//#define  NS_BLOCK_ASSERTIONS


#define     MainDatabaseAvailableContext            @"main data base available context"
#define     MainDatabaseAvailableNotification            @"main data base available notif"


//-----------------------------------------------------------------------
//---------------------------   VIEW CONTROLLER    --------------------------------------
//-----------------------------------------------------------------------
//--------------- Event VIEW -----------------------------------------------------------------------------------------------------------------------------------
#define     EVENTVIEW_ITEM_NUM                 1000
#define     EVENTVIEW_DISPLAY_ITEM_NUM         1000


//-------------------- Recent VIEW -----------------------------------------------------------------------------------------------------------------------------
#define     RECENTVIEW_ITEM_NUM                 50
#define     RECENTVIEW_DISPLAY_ITEM_NUM         50

#define     RECENTVIEW_REFRESH_TIME             5.0


//--------------- MESSAGE VIEW -----------------------------------------------------------------------------------------------------------------------------------
#define     MESSAGEVIEW_ITEM_NUM                 50
#define     MESSAGEVIEW_DISPLAY_ITEM_NUM         50


#define     MESSAGEVIEW_REFRESH_TIME            5.0

//--------------- GROUP VIEW -----------------------------------------------------------------------------------------------------------------------------------
#define     GROUPVIEW_ITEM_NUM                 50
#define     GROUPVIEW_DISPLAY_ITEM_NUM         50
#define     GROUPVIEW_USER_ITEM_NUM            1000

#define     GROUPVIEW_REFRESH_TIME            5.0


//--------------- PEOPLE VIEW -----------------------------------------------------------------------------------------------------------------------------------
#define     PEOPLEVIEW_ITEM_NUM                 1000
#define     PEOPLEVIEW_DISPLAY_ITEM_NUM         1000

//--------------- USER VIEW -----------------------------------------------------------------------------------------------------------------------------------
#define     USERVIEW_ITEM_NUM                 1000
#define     USERVIEW_DISPLAY_ITEM_NUM         1000




//-----------------------------------------------------------------------
//---------------------------   SYSTEM    --------------------------------------
//-----------------------------------------------------------------------
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]

//-------------------------------------------------------------------------------------------------------------------------------------------------
#define		DEFAULT_TAB							0

//-------------------------------------------------------------------------------------------------------------------------------------------------
#define		VIDEO_LENGTH						5

//-------------------------------------------------------------------------------------------------------------------------------------------------
#define		COLOR_OUTGOING						HEXCOLOR(0x007AFFFF)
#define		COLOR_INCOMING						HEXCOLOR(0xE6E5EAFF)

//-------------------------------------------------------------------------------------------------------------------------------------------------
#define		SCREEN_WIDTH						[UIScreen mainScreen].bounds.size.width
#define		SCREEN_HEIGHT						[UIScreen mainScreen].bounds.size.height

//-------------------------------------------------------------------------------------------------------------------------------------------------
#define		PREMIUM_LINK						@"http://www.relatedcode.com/realtimepremium"

//-------------------------------------------------------------------------------------------------------------------------------------------------
#define		MESSAGE_INVITE						@"Please accept our invitation"

//-----------------------------------------------------------------------
//---------------------------   SERVER DATA    --------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//---------------------------   INSTALLATION    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_INSTALLATION_CLASS_NAME			@"_Installation"		//	Class name
#define		PF_INSTALLATION_OBJECTID			@"objectId"				//	String
#define		PF_INSTALLATION_USER				@"user"					//	Pointer to User Class

#define		PF_CURRENT_USER_CLASS_NAME					@"CurrentUser"

//-----------------------------------------------------------------------
//---------------------------   COMMON    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_COMMON_OBJECTID					@"objectId"//	Class name
#define		PF_COMMON_CREATE_TIME                @"createAt"			//	Date
#define		PF_COMMON_UPDATE_TIME                @"updateAt"			//	Date

//-----------------------------------------------------------------------
//---------------------------   USER    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_USER_CLASS_NAME					@"User"				//	Class name
#define		PF_USER_OBJECTID					@"objectId"				//	String
#define		PF_USER_USERNAME					@"username"				//	String
#define		PF_USER_PASSWORD					@"password"				//	String
#define		PF_USER_EMAIL						@"email"				//	String
#define		PF_USER_EMAILCOPY					@"emailCopy"			//	String
#define		PF_USER_FULLNAME					@"fullname"				//	String
#define		PF_USER_FULLNAME_LOWER				@"fullname_lower"		//	String
#define		PF_USER_TWITTERID					@"twitterId"			//	String
#define		PF_USER_FACEBOOKID					@"facebookId"			//	String
#define		PF_USER_PICTURE						@"picture"				//	File
#define		PF_USER_THUMBNAIL					@"thumbnail"			//	File
//-----------------------------------------------------------------------
//---------------------------   BLOCK    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_BLOCKED_CLASS_NAME				@"Blocked"				//	Class name
#define		PF_BLOCKED_USER						@"user"					//	Pointer to User Class
#define		PF_BLOCKED_USER1					@"user1"				//	Pointer to User Class
#define		PF_BLOCKED_USER2					@"user2"				//	Pointer to User Class
#define		PF_BLOCKED_USERID2					@"userId2"				//	String
//-----------------------------------------------------------------------
//---------------------------   GROUP    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_GROUP_CLASS_NAME					@"Group"				//	Class name

#define		PF_GROUP_OBJECTID					@"objectId"

#define		PF_GROUP_USER						@"user"					//	Pointer to User Class
#define		PF_GROUP_NAME						@"name"					//	String
#define		PF_GROUP_MEMBERS					@"members"				//	Array
#define     PF_GROUP_CREATE_TIME                @"createAt"

#define     PF_GROUP_UPDATE_TIME                @"updateAt"
//-----------------------------------------------------------------------
//---------------------------   MESSAGE    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_MESSAGE_CLASS_NAME				@"Message"				//	Class name
#define		PF_MESSAGE_USER						@"user"					//	Pointer to User Class
#define		PF_MESSAGE_GROUPID					@"groupId"				//	String
#define		PF_MESSAGE_TEXT						@"text"					//	String
#define		PF_MESSAGE_PICTURE					@"picture"				//	File
#define		PF_MESSAGE_VIDEO					@"video"				//	File
#define		PF_MESSAGE_CREATEDAT				@"createdAt"			//	Date

//-----------------------------------------------------------------------
//---------------------------   EVENT    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_EVENT_CLASS_NAME                 @"Event"


#define		PF_EVENT_OBJECTID					@"objectId"//	Class name
#define		PF_EVENT_CREATE_TIME                @"createAt"			//	Date
#define		PF_EVENT_UPDATE_TIME                @"updateAt"			//	Date

#define		PF_EVENT_START_TIME                 @"startTime"			//	Date
#define		PF_EVENT_END_TIME                   @"endTime"			//	Date
#define		PF_EVENT_INVITEES                   @"invitees"			//	Date
#define		PF_EVENT_IS_ALERT                   @"isAlert"			//	Date
#define		PF_EVENT_LOCATION                   @"location"			//	Date
#define		PF_EVENT_NOTES                      @"notes"			//	Date
#define		PF_EVENT_TITLE                      @"title"			//	Date
#define		PF_EVENT_SCOPE                      @"scope"			//	Date
#define		PF_EVENT_BOARD_IDS                  @"boardIDs"			//	Date
#define		PF_EVENT_VOTING_ID                  @"votingID"			//	Date
#define		PF_EVENT_MEMBERS                    @"members"			//	Date
#define		PF_EVENT_GROUP_IDS                  @"groupIDs"			//	Date
#define		PF_EVENT_IS_VOTING                  @"isVoting"			//	Date
#define		PF_EVENT_ALERT                      @"alert"			//	Date
#define		PF_EVENT_PLACE                      @"place"			//	Date
#define		PF_EVENT_CREATE_USER                @"createUser"			//	Date
#define		PF_EVENT_CATEGORY                   @"category"			//	Date

//-----------------------------------------------------------------------
//---------------------------   ALERT    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_ALERT_CLASS_NAME                 @"Alert"


#define		PF_ALERT_OBJECTID					@"objectId"//	Class name
#define		PF_ALERT_CREATE_TIME                @"createAt"			//	Date
#define		PF_ALERT_UPDATE_TIME                @"updateAt"			//	Date

#define		PF_ALERT_TIME                       @"time"			//	Date
#define		PF_ALERT_TYPE                       @"type"			//	Date

//-----------------------------------------------------------------------
//---------------------------   EVENT CATEGORY    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_EVENT_CATEGORY_CLASS_NAME        @"EventCategory"


#define		PF_EVENT_CATEGORY_OBJECTID			@"objectId"//	Class name
#define		PF_EVENT_CATEGORY_CREATE_TIME       @"createAt"			//	Date
#define		PF_EVENT_CATEGORY_UPDATE_TIME       @"updateAt"			//	Date

#define		PF_EVENT_CATEGORY_CHILD_ARRAY       @"childArray"			//	Date
#define		PF_EVENT_CATEGORY_CHILD_COUNT       @"childCount"			//	Date
#define		PF_EVENT_CATEGORY_LEVEL             @"level"			//	Date
#define		PF_EVENT_CATEGORY_NAME              @"name"			//	Date
#define		PF_EVENT_CATEGORY_NOTES             @"notes"			//	Date
#define		PF_EVENT_CATEGORY_PARENT            @"parent"			//	Date
#define		PF_EVENT_CATEGORY_RELATED_ARRAY     @"relatedArray"			//	Date
#define		PF_EVENT_CATEGORY_SUB_ARRAY         @"subArray"			//	Date

//-----------------------------------------------------------------------
//---------------------------   EVENT VOTING    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_EVENT_VOTING_CLASS_NAME          @"EventCategory"


#define		PF_EVENT_VOTING_OBJECTID			@"objectId"//	Class name
#define		PF_EVENT_VOTING_CREATE_TIME         @"createAt"			//	Date
#define		PF_EVENT_VOTING_UPDATE_TIME         @"updateAt"			//	Date

#define		PF_EVENT_VOTING_INSTRUCTION         @"instruction"			//	Date
#define		PF_EVENT_VOTING_IS_PRIORITY         @"isPriority"			//	Date
#define		PF_EVENT_VOTING_SELECT_NUM          @"selectNum"			//	Date
#define		PF_EVENT_VOTING_TIME_SPAN           @"timeSpan"			//	Date

#define		PF_EVENT_VOTING_VOTE_ITEMS          @"voteItems"			//	Date
#define		PF_EVENT_VOTING_VOTER_LIST          @"voterList"			//	Date

//-----------------------------------------------------------------------
//---------------------------   EVENT VOTE ITEM    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_EVENT_VOTE_ITEM_CLASS_NAME       @"EventCategory"


#define		PF_EVENT_VOTE_ITEM_OBJECTID			@"objectId"//	Class name
#define		PF_EVENT_VOTE_ITEM_CREATE_TIME      @"createAt"			//	Date
#define		PF_EVENT_VOTE_ITEM_UPDATE_TIME      @"updateAt"			//	Date

#define		PF_EVENT_VOTE_ITEM_SCORE            @"score"			//	Date
#define		PF_EVENT_VOTE_ITEM_VOTE_NUM         @"voteNum"			//	Date
#define		PF_EVENT_VOTE_ITEM_VOTER_NAME       @"voterName"			//	Date
#define		PF_EVENT_VOTE_ITEM_VOTING_ID        @"votingID"			//	Date


//-----------------------------------------------------------------------
//---------------------------   PEOPLE    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_PEOPLE_CLASS_NAME				@"People"				//	Class name
#define		PF_PEOPLE_USER1						@"user1"				//	Pointer to User Class
#define		PF_PEOPLE_USER2						@"user2"				//	Pointer to User Class

#define		PF_PEOPLE_OBJECTID					@"objectId"

#define		PF_PEOPLE_NAME						@"name"

#define     PF_PEOPLE_CREATE_TIME               @"createAt"

#define     PF_PEOPLE_UPDATE_TIME               @"updateAt"

//-----------------------------------------------------------------------
//---------------------------   RECENT    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_RECENT_CLASS_NAME				@"Recent"				//	Class name
#define		PF_RECENT_USER						@"user"					//	Pointer to User Class
#define		PF_RECENT_GROUPID					@"groupId"				//	String
#define		PF_RECENT_MEMBERS					@"members"				//	Array
#define		PF_RECENT_DESCRIPTION				@"description"			//	String
#define		PF_RECENT_LASTUSER					@"lastUser"				//	Pointer to User Class
#define		PF_RECENT_LASTMESSAGE				@"lastMessage"			//	String
#define		PF_RECENT_COUNTER					@"counter"				//	Number
#define		PF_RECENT_UPDATEDACTION				@"updatedAction"		//	Date
//-----------------------------------------------------------------------
//---------------------------   REPORT    --------------------------------------
//-----------------------------------------------------------------------
#define		PF_REPORT_CLASS_NAME				@"Report"				//	Class name
#define		PF_REPORT_USER1						@"user1"				//	Pointer to User Class
#define		PF_REPORT_USER2						@"user2"				//	Pointer to User Class

//-----------------------------------------------------------------------
//---------------------------   NOTIFICATION    --------------------------------------
//-----------------------------------------------------------------------
#define		NOTIFICATION_APP_STARTED			@"NCAppStarted"
#define		NOTIFICATION_USER_LOGGED_IN			@"NCUserLoggedIn"
#define		NOTIFICATION_USER_LOGGED_OUT		@"NCUserLoggedOut"
