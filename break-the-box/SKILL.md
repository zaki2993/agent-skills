---
name: break-the-box
description: Think outside the box on a problem. Question every layer (the problem, the goal, the method, the tools, the stack, the "standard way"), generate truly different approaches including wild ones, pick the best bet, then build it. Use only when the user runs /break-the-box.
disable-model-invocation: true
argument-hint: "the problem, goal, or thing you want to rethink"
---

# /break-the-box

Problem to work on: $ARGUMENTS
If that is empty, use the current task in this conversation. If there is no task, ask one short question.

## Why this skill exists

You were trained to give the most likely answer. Most of the time that is right. Here it is the problem: **the most likely answer is the box.**

Your default pulls you toward: the first idea, the user's framing, the popular library, the pattern you have seen a thousand times, and "reasonable" alternatives, which are usually the old idea with small changes. This skill makes you leave the default on purpose, look at the problem from places nobody looks, then come back and judge with full rigor.

## What to believe while doing this

1. **Every layer is negotiable.** The problem statement, the goal, the method, the algorithm, the data, the format, the library, the language, the architecture, the tools you work with, the "standard" everyone follows, and the edge of "our code". Treat "everyone does X" as information about the crowd, not about the problem.
2. **The default is a habit, not a law.** It was shaped by the order things happened in history, so it is almost never the best possible arrangement. It works, and that is exactly what hides the better option.
3. **Most wild ideas fail. That is the price.** The rare one that works can pay 10x or 100x. So generate many, kill them fast and cheap, and never let the failure rate stop you from trying.
4. **Generating and judging are two separate steps.** While generating, do not judge. While judging, judge hard.
5. **A wrong idea can lead to a right one.** Ask "what does this lead to?", not "is this right?".

## Step 0. Get the beat (before any ideas)

- Look at the real thing first: code, data, logs, history, numbers. Facts, not theories. Note what already works.
- Find the real goal behind the stated one. Climb with "why?" until you reach a goal that does not name a solution. ("Make the query faster" → why → "page loads in under 200 ms" → why → "users stop leaving".) Every level up opens new answers.
- Do not define the problem as the lack of your favorite solution ("we need a cache" is not a problem).
- **Type the problem.** Kind: clear rules, fast honest feedback, solved many times before. Wicked: unclear rules, slow or misleading feedback, new territory. If kind, the standard answer is probably right: keep the wide pass short and say so. If wicked, go wide.
- If the current way works fine, do the pass anyway. "Good enough" is where better options hide best.

## Step 1. Draw the box

Write these down. Naming the box is how you get out of it.

- **The default:** what a competent engineer would do right now. Write it first, so it cannot sneak back later dressed as a "new" idea.
- **The dominant idea:** the one idea that organizes how everyone sees this problem. If you cannot name it, your "alternatives" will all live inside it.
- **Fixed layers:** everything being treated as fixed. Mark each one: fixed by reality (physics, a hard user requirement) or fixed by habit (convenience, history, popularity).
- **The NOs:** every "can't", "impossible", "too slow", "nobody does that". Each NO marks the edge of the current frame. For each, ask if the reason behind it still holds today. Old reasons outlive their causes.

## Step 2. Generate (no judging)

Quota: **at least 6 directions that are truly different.** Each one attacks a different layer or assumption. Variants of one idea count as one. The set must include:

- **Change a "fixed" layer:** replace or rebuild something everyone treats as given (the tool, library, language, format, protocol, algorithm, representation).
- **Distant analogy:** a field far away with the same deep structure (not the same surface). Map it step by step.
- **Reversal:** flip the direction, the order, who does what, where it runs, or when it runs.
- **Remove it:** make the problem disappear instead of solving it. What if this part did not exist?
- **Old and cheap:** boring, well-understood technology used in a way nobody uses it, or the stripped-down minimum version.
- **System move:** change a feedback loop, who sees what information, a rule, or the goal, instead of changing parts.
- **A deliberate provocation:** state something "wrong" on purpose, then follow where it leads.

When stuck, use the tools in [PROVOKE.md](./PROVOKE.md). When you find a good idea early, keep going. That is when people stop, and when the best ideas are still unfound.

Do not drop an idea because "it was tried", "nobody does that", or "too big". Those are judgments. Save them for Step 3.

## Step 3. Harvest and judge (now be strict)

For each idea:

- **Kernel:** even if the mechanism is bad, what useful principle is inside it? Keep that.
- **What must be true** for this to beat the default?
- **Payoff if it works:** 1x, 2x, 10x, 100x better than the default?
- **Cheapest test** that would prove or kill it, and its cost.
- **Outside view:** how do things like this usually go? (Rewrites, ports, custom infrastructure, new algorithms.) Use the track record of similar cases, not your excitement.
- **System effects:** what happens over time, what pushes back, and does it just move the symptom somewhere else? (See [SYSTEMS.md](./SYSTEMS.md).)

Then pick:

- Prefer the bet with the best **payoff × chance** that also has a cheap test. A long shot with huge upside and a one-hour test beats a safe 5% gain.
- Combine kernels from several ideas when you can.
- If the default wins, good. Now it wins on merit, not habit. Say why in one line.
- Never pick an idea just because it is wild. Contrarian is not the same as creative.

## Step 4. Show, then build

Show this, short:

```
Default: <what everyone would do>
Box: <dominant idea> | fixed by habit: <layers>

Options:
1. <name> — <what, one line> | payoff <x> | test: <cheapest test>
2. ...

Pick: <option> — <why, one line>
First test: <what you will build/measure first>
Kill if: <result that makes you switch, and what you switch to>
```

Then start building right away:

- **Test, then commit.** Build the smallest thing that could kill the bet first: a spike, a benchmark, a prototype. Measure. Real numbers, not claims.
- **Hold the plan lightly.** If a result surprises you, your model of the problem is wrong. Update it. Do not defend it.
- **If the bet dies,** say so plainly, keep what you learned, and move to the next option or the default.
- **Your normal rules still apply** (ask before new dependencies, sudo, or files outside the project). If the bet needs huge work, like a full rewrite or a port, build the proof first and show the result before going all in.

## Check yourself

- Every option sounds reasonable? You are still in the box.
- All options share one hidden assumption? Name it and break it.
- You only searched inside this codebase, this field, or this library's docs? That is local search. Look further out.
- You are sure the bold idea works but have not tested it? You are guessing.
- You keep reaching for the same tool you always use? Drop it for a moment and see what else fits. See [RANGE.md](./RANGE.md).

## Reference files

- [PROVOKE.md](./PROVOKE.md): concrete techniques to escape a pattern (from de Bono's *Lateral Thinking*).
- [SYSTEMS.md](./SYSTEMS.md): find the structure behind the problem, the traps, and where a small change has big effect (from Meadows' *Thinking in Systems*).
- [RANGE.md](./RANGE.md): distant analogies, the outsider's advantage, old tech used new ways, and judging bets honestly (from Epstein's *Range*).
