function fragment_title_get(_id) {
    switch (_id) {
        case "l1_sample_496": return "Sample 496-A, Acquisition Notes";
        case "l1_pulse_logs": return "Pulse Logs, Long-Range Array";
        case "l2_katya_log": return "K. Snezhevna, Personal Log #41";
        case "l2_fleet_directive": return "Fleet Directive 13-NP-OMEGA";
    }
    return "Unknown Fragment";
}

function fragment_text_get(_id) {
    switch (_id) {
        case "l1_sample_496":
            return
                "Recovered from drift inside the nebula at 14:22 ship-time.\n" +
                "Visually: pink, semi-translucent, irregular. No movement on retrieval.\n" +
                "First-pass spectrometry returned garbage - every reading the instrument can produce, simultaneously.\n\n" +
                "Working hypothesis: a previously undocumented metamaterial. Density is impossible. Energy throughput is impossible. The thing is impossible and it is sitting in our containment vat.\n\n" +
                "Naming convention is going to be a problem. Dr. Vass is calling it Idyllium, from idyll. He says we are looking at infinite possibility. I think we are looking at a rock that lies to instruments.\n\n" +
                "- H. Mariko, Materials Lead";

        case "l1_pulse_logs":
            return
                "03:11 - pulse detected. Source bearing: nebula interior. Duration 0.4s.\n" +
                "11:47 - pulse detected. Same bearing. Duration 0.4s.\n" +
                "19:02 - pulse detected. Same bearing. Duration 0.4s.\n" +
                "02:55 - pulse detected. Same bearing. Duration 6.1s.\n\n" +
                "[margin note]\n" +
                "the long one is new. nobody is taking this seriously because the research grant does not cover it. the grant covers the rock. so we study the rock.";

        case "l2_katya_log":
            return
                "They sent the sample over. They sent it over because they are afraid of it. They are afraid of it because they do not understand it. Of course they do not. They are scientists. They look. I make.\n\n" +
                "If I am right about the energy density - and I am right - then a single gram of this could move a freighter. Ten grams could move a fleet. A kilogram could move a city.\n\n" +
                "They will let me have it. They will have to. They have nowhere else to put it now that it is loose. I have already begun preparing the harness.\n\n" +
                "Come and see me, little sample. Come and see what I will build out of you.";

        case "l2_fleet_directive":
            return
                "FROM: Admiral H. Goldthwait, Nebula Picket Fleet Command\n" +
                "TO: Captain Voss, UES Huygens\n" +
                "RE: ANS-13 forward research station - escalation authority\n\n" +
                "Captain.\n\n" +
                "Long-range comms with the ANS-13 research station have degraded over the last cycle. We assume signal interference from the nebula until proven otherwise. You will divert the Huygens to the system, conduct a status inspection of the research vessel personally, and report back inside the standard window.\n\n" +
                "If the situation on the ground does not match the situation we have been told about, you have full escalation authority. I do not need to tell you what that means. You and I have served together long enough.\n\n" +
                "Bring the ship home, Voss.\n\n" +
                "- Goldthwait";
    }
    return "No data.";
}