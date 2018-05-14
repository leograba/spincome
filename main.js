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

function initialRootState(tabName, rootTab) {
    console.debug("main.js: setRootTab: tab name is: " + tabName)
    roots[tabName] = rootTab
}

function applyRootState(tabName, stateToApply){
    console.debug("main.js: applyRootState: state " + stateToApply + " applied to " + tabName)
    roots[tabName].state = stateToApply
}

function configureSwipe(swp){
    swipe = swp;
}

function setSwipeIndex(idx){
    swipe.currentIndex = idx
}

function goToLogin(){
    setSwipeIndex(0)
}
