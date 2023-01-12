//This object holds all the functions to track page visits
const mixPageFunctions = {
	"pages welcome": () => mixpanel.track("Welcome Page View"),
	"pages about": () => mixpanel.track("About Page View"),
	"pages ourteam": () => mixpanel.track("Our Team Page View"),
	"pages foundingdonors": () => mixpanel.track("Founding Donors Page View"),
	"pages howitworks": () => mixpanel.track("How It Works Page View"),
	"pages campaigns": () => mixpanel.track("Campaigns Page View"),
	"pages generalfund": () => mixpanel.track("General Fund Page View"),
	"pages faq": () => mixpanel.track("Contact Us Page View"),
	"pages privacy": () => mixpanel.track("Privacy Page View"),
	"pages terms": () => mixpanel.track("T&C Page View"),
	"campaigns show": () => mixpanel.track("Campaigns Show Page View"),
	"donations new": () => mixpanel.track("New Donation Page View"),
	"sessions new": () => mixpanel.track("Sign In Page View"),
	"registrations new": () => mixpanel.track("Register Page View"),
	"registrations edit": () => mixpanel.track("Donor Edit Page View"),
	"projects index": () => mixpanel.track("Projects Page View"),
	"donors show": () => mixpanel.track("Donor Show Page View"),
	"no-tag": () => mixpanel.track("Untracked Page")
}

//This function grabs the mix panel meta tag and returns its contents for page identification
function pageIdentity() {
	var mixMetaTag=document.querySelector('meta[property="mix-page"]');
	return (mixMetaTag ? mixMetaTag.content : "no-tag");
}

// On page load calls the mixpanel function for the corresponding page
$(document).on("turbolinks:load", function () {
	if (mixPageFunctions[pageIdentity()]) mixPageFunctions[pageIdentity()]();
});

//Mix panel click event functions
const mixClickFunctions= {
	homeClick : function () {
		mixpanel.track("Home Button Click")
	},
	aboutClick : function () {
		mixpanel.track("About Link Click- Navbar")
	},
	campaignClick : function () {
		mixpanel.track("Campaign Link Click-Navbar")
	},
	howItWorksClick : function () {
		mixpanel.track("How It Works Link Click-Navbar")
	},
	signInClick : function () {
		mixpanel.track("Sign In Link Click-Navbar")
	},
	//donationClick: function () {
	//	mixpanel.track("Donate Button Click")
	//},
	campaignCardClick: function(campaignId) {
		mixpanel.track("Campaign Card Click", {
			"Campaign ID": campaignId
		});
	},
	patientsLinkClick: function() {
		mixpanel.track("Patient Projects Link Click");
	},
	healthInsuranceLinkClick: function() {
		mixpanel.track("Health Insurance Projects Link Click");
	},
	classroomsLinkClick: function() {
		mixpanel.track("Classroom Projects Link Click");
	},
	impactLinkClick: function() {
		mixpanel.track("Impact Stories Link Click");
	},
	donateBtnClick: function (campaignId) {
		mixpanel.track("Campaign Page Donate Button Click", {
			"Campaign Id": campaignId
		});
	},
	donateByCardClick: function (campaignId) {
		mixpanel.track("Donate By Credit Card Click", {
			"Campaign Id": campaignId
		});
	},
	donateByHubTelClick: function (campaignId) {
		mixpanel.track("Donate Via HUBTEL Click", {
			"Campaign Id": campaignId
		});
	},
	donorLogIn: function (email) {
		mixpanel.identify(email)
		mixpanel.track("Donor Login")
	},
	donorSignUp: function (email, name) {
		mixpanel.alias(email)
		mixpanel.track("Donor Sign Up")
		mixpanel.people.set({
			"$email": email,
			"Full Name": name
		})
	}
}
//Generic function to add a mix function to multiple nodes in a list
function addEventListeners(nodeList, mixFunction, dataAttribute) {
	for (var i=0; i<nodeList.length; i++) {
		nodeList[i].addEventListener("click", function () {
			mixFunction(this.getAttribute(dataAttribute))
		});
	}
}
//Grabs the email address from a donor login/signup form to send to mix panel
//function getFormValue(id) {
//	return document.getElementById(id).value
//}

//Adding the mixpanel functions to the dom elements

	$(document).on('turbolinks:load', function () {
	//track home button clicks
  	let homeButton= document.querySelector(".navbar-brand");
	  if (homeButton) homeButton.addEventListener("click", mixClickFunctions.homeClick)

	//track About us Navbar Clicks
	let aboutUsNav= document.querySelector("#about-us-nav")
	if (aboutUsNav) aboutUsNav.addEventListener("click", mixClickFunctions.aboutClick)

	//track Campaigns Navbar Clicks
	let campaignsNav= document.querySelector("#campaigns-nav")
	if (campaignsNav) campaignsNav.addEventListener("click", mixClickFunctions.campaignClick)

	//track How It Works Navbar Clicks
	let howItWorksNav= document.querySelector("#how-it-works-nav")
	if (howItWorksNav) howItWorksNav.addEventListener("click", mixClickFunctions.howItWorksClick)

	//track Sign In Navbar Clicks
	let signInNav= document.querySelector("#sign-in-nav")
	if (signInNav) signInNav.addEventListener("click", mixClickFunctions.signInClick)

	//track campaign card img clicks with campaign ID
	let campaignCardLink=document.querySelectorAll(".camp-card-lnk");
	if (campaignCardLink) {
		addEventListeners(campaignCardLink, mixClickFunctions.campaignCardClick, "data-campaign-id")
	}
	//track campaign card donate button clicks with campaign ID
	let btnOnCard=document.querySelectorAll("#card-dn-btn");
	if (btnOnCard) {
		addEventListeners(btnOnCard, mixClickFunctions.campaignCardClick, "data-campaign-id")
	  }

	//links to project categories from homepage
	let linkToPatientsProjs= document.querySelector("#Patients");
	if (linkToPatientsProjs) linkToPatientsProjs.addEventListener("click", mixClickFunctions.patientsLinkClick)

	let linkToHIProjs= document.querySelector("#Health-Insurance");
	if (linkToHIProjs) linkToHIProjs.addEventListener("click", mixClickFunctions.healthInsuranceLinkClick)

	let linkToClassroomProjs= document.querySelector("#Classroom-Supplies");
	if (linkToClassroomProjs) linkToClassroomProjs.addEventListener("click", mixClickFunctions.classroomsLinkClick)

	//Homepage link to flicker account
	let impactStories = document.querySelector("#story-btn");
	if (impactStories) impactStories.addEventListener("click", mixClickFunctions.impactLinkClick)

	//Campaign page Donate Button Click
	let donateBtn = document.querySelector("#cam-dn-btn");
	if (donateBtn) {
		donateBtn.addEventListener("click", function () {
			mixClickFunctions.donateBtnClick(this.getAttribute("data-campaign-id"))
		});
	}
	//Credit Card donate button click
	let cCdonateBtn = document.querySelector("#cc-dn-btn");
	if (cCdonateBtn) {
		cCdonateBtn.addEventListener("click", function () {
			mixClickFunctions.donateByCardClick(this.getAttribute("data-campaign-id"))
		});
	}
	//hubtel link donate button click
	let hbtldonateBtn = document.querySelector("#hbtl-dn-btn");
	if (hbtldonateBtn) {
		hbtldonateBtn.addEventListener("click", function () {
			mixClickFunctions.donateByHubTelClick(this.getAttribute("data-campaign-id"))
		});
	}
	//code for tracking log in/ sign up on front end
	//Track Donor log ins
	//let donorLogin = document.querySelector("#donor-login");

	//if (donorLogin) {
	//	donorLogin.addEventListener("click", function () {
	//		console.log("emails")
	//		console.log(getFormValue("donor_email"))
	//		mixClickFunctions.donorLogIn(getFormValue("donor_email"))
	//	});
	//}
	//Track Donor Sign ups
	//let donorSignUp = document.querySelector("#donor-sign-up");

	//if (donorSignUp) {
	//	donorSignUp.addEventListener("click", function () {
	//		mixClickFunctions.donorSignUp(getFormValue("donor_email"), getFormValue("donor_fullname"))
	//	})
	//}

	// passes the mixpanel id to the backend
	let donorSignUp = document.querySelector("#donor-sign-up");

	if (donorSignUp) {
		donorSignUp.addEventListener("click", function () {
			document.querySelector("#mixId").value=mixpanel.get_distinct_id()
		});
	}
	// I dont think this is needed
	//let donorLogin = document.querySelector("#donor-login");

	//if (donorLogin) {
	//	donorLogin.addEventListener("click", function () {
	//	document.querySelector("#mixId").value=mixpanel.get_distinct_id()
	//	});
	//}

	//mix-id content is set only after successful log in
	//triggers the identify call to complete user tracking
	var mixMetaId=document.querySelector('meta[property="mix-id"]');
	if (mixMetaId.content) {
		mixpanel.identify(mixMetaId.content)
	}

	});
