.pragma library
/* This file is meant to handle the logic between tabs of the main application*/

// Properties
var roots = {}
//var rootDashboard;
//var rootExprev;
//var rootBudget;
//var rootInvest;
//var rootStat;
//var rootStrategy;
var swipe;
var loggedIn = false;

function login(){
    /* Use after a successful login */
    loggedIn = true
}

function logout(){
    /* Use after a successful logout */
    loggedIn = false
}

function isLoggedIn(){
    /* Return the login status */
    return loggedIn
}

function initialRootState(tabName, rootTab) {
    /* Hold the objects that contain the state of the tabs
       Should be called onComplete, to get the initialRootState*/
    console.debug("main.js: setRootTab: tab name is: " + tabName)
    roots[tabName] = rootTab
}

function applyRootState(tabName, stateToApply){
    /* Apply a state to a tab */
    console.debug("main.js: applyRootState: state " + stateToApply + " applied to " + tabName)
    roots[tabName].state = stateToApply
}

function getRootState(tabName){
    /* Get tab state */
    return roots[tabName].state
}

function stateLoginFail(){
    /* Set all tabs view to the state before successful login */
    applyRootState("dashboard", "login_fail")
    applyRootState("exprev", "nologin")
}

function stateLoginSuccess(){
    /* Set all tabs view to the state when successful login */
    applyRootState("dashboard", "login_success")
    applyRootState("exprev", "")
}

function configureSwipe(swp){
    /* Hold the object that contains the swipe information
      which sets the current tab */
    swipe = swp;
}

function setSwipeIndex(idx){
    /* Go to a specific tab */
    swipe.currentIndex = idx
}

function getSwipeIndex(){
    /* Get the current tab information */
    return swipe.currentIndex
}

function goToLogin(){
    /* Go specifically to the login tab */
    setSwipeIndex(0)
}
