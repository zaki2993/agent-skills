# SYSTEMS: find the structure behind the problem

Source: Donella Meadows, *Thinking in Systems*.

**Why this matters for thinking outside the box:** most "obvious" fixes act on the visible parts and numbers. The behavior comes from the structure (the loops, delays, information flows, rules, and goals). If you replace a broken thing but keep the thinking that produced it, the same thinking will produce another broken thing. Look one level deeper than everyone else and you find options nobody else sees.

## 1. The system causes its own behavior

A Slinky bounces when you remove your hand. A box held the same way does not. The behavior was inside the spring; your hand only released it.

- Stop asking "who or what is to blame?" Ask "**what is the system that produces this?**"
- The same push on a different system gives a different result. Outside events trigger behavior; structure decides it.
- If A seems to cause B, ask whether B also causes A.

## 2. Events, behavior, structure

- **Events** (it crashed, it got slow, sales dropped) are the tip of the iceberg. Explaining event by event ("it failed because X happened") predicts nothing and changes nothing.
- **Behavior over time** (it gets slower every week, it crashes in cycles) is deeper. Look at the history and the graph before you theorize. Memories lie about timing and trends.
- **Structure** (stocks, flows, feedback loops, delays) is where the real options live.
- Correlations between two numbers hold only until the structure changes. They can predict, but they cannot tell you how to improve.

## 3. Parts, connections, purpose

A system is parts + connections + a purpose.

- Changing **parts** (swap a library, replace a person, rewrite a module in the same design) usually changes the least.
- Changing **connections** (who talks to whom, what flows where, the rules) can change everything.
- Changing the **purpose** changes everything, even with the same parts and connections.
- Learn the real purpose from **behavior**, not from what anyone says. If a project "values speed" but spends every week on process, its purpose is the process.
- Sub-goals can add up to a result nobody wants (each team optimizes its own metric and the product gets worse).

## 4. Stocks, flows, feedback, delays

- A **stock** is anything that accumulates (data, debt, users, bugs, trust, skill). It changes only through flows, and it changes slowly.
- **You can raise a stock by lowering its outflow, not only by raising its inflow.** Keeping users can beat finding new ones. Fewer bugs created can beat more bugs fixed. Using less can beat finding more. People forget the outflow.
- **Balancing loops** pull toward a goal and resist change. **Reinforcing loops** feed themselves into runaway growth or collapse.
- **Feedback only affects the future.** Every loop has a delay. A delay in a correcting loop makes the system oscillate.
- **Acting faster can make it worse.** In the book's inventory model, reacting faster made the swings bigger; reacting slower calmed them. This is a classic case of "high leverage, wrong direction": people find the right lever and pull it the wrong way.
- Things take longer than people think. Estimate a delay, then multiply by three.

## 5. Same structure, same behavior

Systems with the same loop structure behave the same way, even when they look nothing alike. A cooling coffee cup behaves like a decaying isotope and an aging fleet of machines. A population grows like invested capital.

This is why distant analogies work. Find the structure of your problem, then look for solved problems with the same structure in other fields.

## 6. Why systems surprise us

- **Nonlinear:** twice the push does not give twice the result. More of a good thing can turn bad (fertilizer, caching, parallelism, features). Watch for thresholds where behavior flips (a traffic jam forms suddenly).
- **Boundaries are made up.** Draw them around the question, not around the codebase, team, or field. Too narrow and you get surprised (build a highway, get more traffic). Too wide and you drown. Whatever you treat as "outside" (a cloud in the diagram) should start your thinking, not stop it.
- **Limiting factor:** what matters most is the input that is most limiting right now. Adding more of what is already plentiful does nothing. Fixing one limit makes another one the limit, so watch for the next one.
- **Bounded rationality:** people act sensibly on the information they can see. Put anyone in that seat and they will do the same. So change the information, incentives, and goals, not the person.

## 7. Traps (and the way out)

| Trap | What it looks like | Way out |
|---|---|---|
| **Fixes that fail** | Many actors pull one thing toward different goals; every push brings a bigger push back | Let go of the forcing; find a goal everyone can share |
| **Shifting the burden** | A fix hides the symptom (retries, bigger servers, a workaround, a manual step) and the system's own ability to fix itself fades, so it needs more fix | Ask why the natural fix fails; strengthen it; as the helper, build capacity and then step out |
| **Drift to low performance** | Standards slide to match recent results ("about what we expected") | Keep standards fixed, or set them by the best past result, not the worst |
| **Escalation** | Each side sets its goal as "a bit more than the other" | Refuse to race, or agree on limits |
| **Success to the successful** | Winners get the means to win more (the big module gets all the attention) | Diversify into another game; cap any one winner; level the field |
| **Rule beating** | The letter of the rule is met, the purpose is not | Treat it as feedback; rewrite the rule so cleverness goes toward its purpose |
| **Wrong goal** | The system delivers exactly the metric you set, not what you wanted (coverage, not quality; benchmark, not real use) | Measure the real result; never confuse effort with result |
| **Tragedy of the commons** | A shared resource gets used up because its cost is spread out | Restore the missing feedback to each user, or regulate access |

"Something stupid happens because it's the rule" = wrong goal. "Something stupid happens because it's the way around the rule" = rule beating.

## 8. Leverage points (weakest to strongest)

Most attention goes to the weakest ones.

12. **Numbers:** parameters, thresholds, sizes, config values, tuning. About 95% of the effort, little leverage. Rearranging deck chairs. They matter only when they push the system past a threshold.
11. **Buffers:** the size of stabilizing stocks (queues, caches, reserves). Bigger means more stable but slower and costlier.
10. **Physical structure:** the layout of stocks and flows. Very powerful at design time, expensive to change later.
9. **Delays:** often fixed, but changing one can change everything. Check the direction first.
8. **Balancing loops:** strength of the corrections. Do not delete rarely used safety loops because they look wasteful.
7. **Reinforcing loops:** slowing a runaway loop beats building better brakes.
6. **Information flows:** who sees what, when. Often the cheapest high-leverage move. Dutch houses with the electricity meter in the front hall used about a third less power than identical houses with the meter in the basement. Same price, same people, only the feedback moved.
5. **Rules:** incentives, constraints, who decides. Power over the rules is real power.
4. **Self-organization:** the ability to add, change, or evolve structure. It needs variety and the freedom to experiment, which feels like losing control.
3. **Goals:** everything lower bends to serve the goal. Change the goal and all the rest follows.
2. **Paradigm:** the unstated shared assumptions that the goals, rules, and structure come from. One person can change theirs in a second. Groups resist it more than anything else.
1. **Transcend paradigms:** hold every paradigm, including your own, as a model. No model is "true". Choose the one that serves the purpose.

**Use:** for every option you generate, ask which level it acts on. If all your options are at 10-12, you are still in the box. Push at least one option to level 6 or higher.

## 9. Resilience vs. over-optimization

- Racing sailboats became so tuned to the race rules that any change in the rules makes them useless. Over-fitting to today's conditions kills resilience.
- Just-in-time and maximum efficiency remove buffers. It works until the day it does not.
- Resilience is invisible until you break it. Don't trade it away for a benchmark win without saying so.
- Before removing a part you don't understand, find out what it does. ("Keep every cog and wheel.")

## 10. Habits of systems thinkers

- **Get the beat:** watch the system's history before changing anything. Ask: how did we get here, where is this heading, what is working well?
- **Expose your mental model:** write your assumptions down as boxes and arrows or a list. Keep several explanations alive until evidence kills one. Then you can accept evidence against the one you like.
- **Feedback policies:** design solutions that adjust to the system's state and that review themselves (a rule with built-in check-ins), not fixed one-time decisions.
- **Put responsibility inside:** the person who decides should feel the result fast. (The pilot sits at the front of the plane. Put your water intake downstream of your own waste pipe.)
- **Value the important, not just the measurable.** Leaving out what can't be measured gives a wrong model.
- **Defy the disciplines:** follow the problem wherever it leads, across fields. Learn from each field's lens, but don't be limited by it.
- **Stay a learner:** don't bluff and don't freeze. Take small steps, watch closely, and change course when the evidence says so.
