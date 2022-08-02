import "commonReactions/all.dsl";

context 
{
    // declare input variables here. phone must always be declared. name is optional 
    input phone: string;
    input name: string = ""; 

    // declare storage variables here 
    var1: string = "";

}

// declare external functions here 
external function function1(log: string): string;

// lines 28-42 start node 
start node root 
{
    do //actions executed in this node 
    {
        #connectSafe($phone); // connecting to the phone number which is specified in index.js that it can also be in-terminal text chat
        #waitForSpeech(1000); // give the person a second to start speaking 
        #say("greeting", {name: $name} ); // and greet them. Refer to phrasemap.json > "greeting" (line 12); note the variable $name for phrasemap use
        #say("menu_1");
        wait *;

    }
    transitions // specifies to which nodes the conversation goes from here 
    {

        // direct_deposit: goto direct_deposit on #messageHasIntent("direct_deposit");

    }
}

// lines 73-333 are our perfect world flow
// digression directDeposit
// {
//     conditions {on #messageHasIntent("direct_deposit");}
//     do 
//     {
//         #sayText("Are you talking about direct deposit form", repeatMode: "ignore"); 
//         #repeat(); // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node 
//         return; // go back to the node from which we got distracted into the digression 
//     }
// }

digression paymentweeklycertification
{
    conditions {on #messageHasIntent("payment_weekly_certification");}
    do 
    {
        #sayText("Message Block", repeatMode: "ignore"); 
        #say("menu_2"); // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node 
        return; // go back to the node from which we got distracted into the digression 
    }
}

digression missing_payment
{
    conditions {on #messageHasIntent("missing_payment");}
    do 
    {
        #sayText("Message Block", repeatMode: "ignore"); 
        #say("menu_3"); 
        wait*;
                        // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node  // go back to the node from which we got distracted into the digression 
    }
    transitions
    {
        correctWeeklyCerfitication: goto correctWeeklyCertification on #messageHasData("1");
        missingWeeklyCertification: goto missingWeeklyCertification on #messageHasData("2");
        correctWeeklyCertificationIntent: goto correctWeeklyCertification on #messageHasIntent("direct_deposit");

        
    }
}
node correctWeeklyCertification{
   
    do{
        #sayText("Message Block", repeatMode: "ignore"); 

    }

}

node missingWeeklyCertification{
     
    do{
        #sayText("Message Block", repeatMode: "ignore"); 
        #say("menu_4");
        wait*;

    }
    transitions
    {
        submitWeeklyCertification: goto submitWeeklyCertification on #messageHasData("1");
        weeklyCertificationTutorial: goto weeklyCertificationTutorial on #messageHasData("2");

        
    }

}

node submitWeeklyCertification{
    do{
        #sayText("https://beacon.labor.maryland.gov", repeatMode: "ignore"); 

    }

}

node weeklyCertificationTutorial{
    do{
        #sayText("https://youtube.com", repeatMode: "ignore"); 

    }

}
digression stakeholder
{
    conditions {on #messageHasIntent("stakeholder");}
    do 
    {
        #sayText("Wait I will fetch your Stakeholder ID", repeatMode: "ignore"); 
        #repeat(); // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node 
        return; // go back to the node from which we got distracted into the digression 
    }
}

digression refund
{
    conditions {on #messageHasIntent("refund");}
    do 
    {
        #sayText("Give me a minute to get you the refund application", repeatMode: "ignore"); 
        #repeat(); // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node 
        return; // go back to the node from which we got distracted into the digression 
    }
}

digression retirement_application
{
    conditions {on #messageHasIntent("retirement_application");}
    do 
    {
        #sayText("Give me a minute to get you the retirement application", repeatMode: "ignore"); 
        #repeat(); // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node 
        return; // go back to the node from which we got distracted into the digression 
    }

}

digression address
{
    conditions {on #messageHasIntent("address");}
    do 
    {
        #sayText("Our addresss is 221 B Baker Street", repeatMode: "ignore"); 
        #repeat(); // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node 
        return; // go back to the node from which we got distracted into the digression 
    }

}


node direct_deposit 
{
    do 
    {
        #say("no");
        exit;
    }
}

digression how_are_you
{
    conditions {on #messageHasIntent("how_are_you");}
    do 
    {
        #sayText("I'm well, thank you!", repeatMode: "ignore"); 
        #repeat(); // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node 
        return; // go back to the node from which we got distracted into the digression 
    }
}
node new_node0 { do {} transitions {} }


