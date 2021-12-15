(
s.waitForBoot{
	~major = Scale.major; // a major scale.
	c = 60;
	d = 62;
	g = 55;

	// list of scale degree chords
	~tonic = [0,2,4];
	~supertonic = [1,3,5];
	~mediant = [2,4,6];
	~subdominant = [3,5,7];
	~dominant = [4,6,8];
	~submediant = [5,7,9];
	~leading = [6,8,10];

	~majorChordGen = {
		|root, degree|
		root + (~major.degrees ++ (~major.degrees +
		12)).at(degree);
	};

//DMAJ tonic, EMIN supertonic, F#MIN mediant, GMAJ subdominant
//AMAJ dominant, BMIN submediant, C#DIM subtonic
	~chordsInD = [
		[~tonic, ~dominant, ~submediant, ~subdominant],
		[~submediant, ~mediant, ~subdominant, ~supertonic],
		[~submediant, ~subdominant, ~tonic, ~dominant],
		[~subdominant, ~supertonic, ~submediant, ~mediant],
		[~tonic, ~submediant, ~mediant, ~subtonic],
		[~tonic, ~submediant, ~subdominant, ~dominant],
		[~submediant, ~subdominant, ~supertonic, ~mediant],
		[~tonic, ~submediant, ~supertonic, ~dominant],
		[~tonic, ~mediant, ~subdominant, ~submediant],
		[~subdominant, ~tonic, ~subdominant, ~dominant]
	];

	~chordsInG = [
		[~tonic, ~tonic, ~subdominant, ~dominant],
		[~tonic, ~subdominant, ~tonic, ~subdominant],
		[~tonic, ~subdominant, ~tonic, ~dominant],
		[~submediant, ~supertonic, ~dominant, ~tonic],
		[~subdominant, ~tonic, ~dominant, ~submediant],
		[~tonic, ~dominant, ~subdominant, ~dominant],
		[~submediant, ~subdominant, ~dominant, ~tonic],
		[~submediant, ~dominant, ~tonic, ~tonic],
		[~tonic, ~subdominant, ~submediant, ~dominant],
		[~subdominant, ~dominant, ~subdominant, ~subdominant]
	];

	~chordsInC = [
		[~supertonic, ~dominant, ~tonic, ~submediant],
		[~tonic, ~subdominant, ~dominant, ~tonic],
		[~tonic, ~mediant, ~subdominant, ~dominant],
		[~tonic, ~mediant, ~subdominant, ~tonic],
		[~tonic, ~supertonic, ~dominant, ~tonic],
		[~tonic, ~supertonic, ~mediant, ~submediant],
		[~tonic, ~submediant, ~subdominant, ~dominant],
		[~tonic, ~submediant, ~supertonic, ~dominant],
		[~submediant, ~subdominant, ~dominant, ~submediant],
		[~mediant, ~submediant, ~dominant, ~submediant],
		[~subdominant, ~tonic, ~mediant, ~submediant],
		[~submediant, ~supertonic, ~mediant, ~submediant]
	];

	~current = 'c';

	n = NetAddr("127.0.0.1", /1337);
	x = OSCFunc({ | msg, time, addr, recvPort |
		msg.post;
		/*
		~msg = msg[0];
		if (~msg == True, ~key = ~current);
		if (~msg ==
		if ((~key == 'c' and ~current == 'c'),
			{~prog = ~chordsInC.choose;
			 ~progression = Array.with(~majorChordGen.value(c, ~prog[0]), ~majorChordGen.value(c, ~prog[1]), ~majorChordGen.value(c, ~prog[2]), ~majorChordGen.value(c, ~prog[3]));
			 ~current = 'c';
			};
		);
		if ((~key == 'g' and ~current == 'g'),
			{~prog = ~chordsInG.choose;
			 ~progression = Array.with(~majorChordGen.value(g, ~prog[0]), ~majorChordGen.value(g, ~prog[1]), ~majorChordGen.value(g, ~prog[2]), ~majorChordGen.value(g, ~prog[3]));
			 ~current = 'g';
			};
		);
		if ((~key == 'd' and ~current == 'd'),
			{~prog = ~chordsInD.choose;
			 ~progression = Array.with(~majorChordGen.value(d, ~prog[0]), ~majorChordGen.value(d, ~prog[1]), ~majorChordGen.value(d, ~prog[2]), ~majorChordGen.value(d, ~prog[3]));
			 ~current = 'd';
			};
		);
		if ((~key == 'd' and ~current == 'c'),
			{var option = [0, 1].choose;
				if (option == 0,
					{~progression = Array.with(~majorChordGen.value(d, ~supertonic), ~majorChordGen.value(d, ~dominant), ~majorChordGen.value(d, ~tonic))});
				if (option == 1,
					{~progression = Array.with(~majorChordGen.value(d, ~subdominant), ~majorChordGen.value(d, ~dominant), ~majorChordGen.value(d, ~tonic))});
			 ~current = 'd';
			};
		);
		if ((~key == 'd' and ~current == 'g'),
			{var option = [0, 1].choose;
				if (option == 0,
					{~progression =  Array.with(~majorChordGen.value(g, ~submediant), ~majorChordGen.value(d, ~subdominant), ~majorChordGen.value(d, ~tonic))});
				if (option == 1,
					{~progression = Array.with(~majorChordGen.value(g, ~mediant), ~majorChordGen.value(g, ~supertonic)[1] = ~majorChordGen.value(g, ~supertonic)[1] + 1, ~majorChordGen.value(d, ~tonic))});
			 ~current = 'd';
			};
		);
		if ((~key == 'g' and ~current == 'c'),
			{var option = [0, 1].choose;
				if (option == 0,
					{~progression = Array.with(~majorChordGen.value(c, ~subdominant), ~majorCordGen.value(c, ~supertonic)[1] = ~majorChordGen.value(c, ~supertonic)[1] + 1, ~majorChordGen.value(g, ~tonic))});
				if (option == 1,
					{~progression = Array.with(~majorChordGen.value(c, ~submediant), ~majorChordGen.value(c, ~supertonic)[1] = ~majorChordGen.value(c, ~supertonic)[1] + 1, ~majorChordGen.value(c, ~dominant))});
			 ~current = 'g';
			};
		);
		if ((~key == 'g' and ~current == 'd'),
			{var option = [0, 1].choose;
				if (option == 0,
					{~progression = Array.with(~majorChordGen.value(d, ~supertonic), ~majorChordGen.value(g, ~dominant), ~majorChordGen.value(g, ~tonic))});
				if (option == 1,
					{~progression = Array.with(~majorChordGen.value(d, ~submediant), ~majorChordGen.value(d, ~dominant)[1] = ~majorChordGen.value(d, ~dominant)[1] + 1, ~majorChordGen.value(g , ~tonic))});
			 ~current = 'g';
			};
		);
		if ((~key == 'c' and ~current == 'g'),
			{var option = [0, 1].choose;
				if (option == 0,
					{~progression = Array.with(~majorChordGen.value(g, ~supertonic), ~majorChordGen.value(c, ~subdominant), ~majorChordGen.value(c, ~dominant), ~majorChordGen.value(c, ~tonic))});
				if (option == 1,
					{~progression = Array.with(~majorChordGen.value(g, ~subdominant), ~majorChordGen.value(c, ~subdominant), ~majorChordGen.value(c, ~tonic))});
			 ~current = 'c';
			};
		);
		if ((~key == 'c' and ~current == 'd'),
			{var option = [0, 1].choose;
				if (option == 0,
					{~progression = Array.with(~majorChordGen.value(d, ~supertonic), ~majorChordGen.value(d, ~subdominant), ~majorChordGen.value(c, ~tonic))});
				if (option == 1,
					{~progression = Array.with(~majorChordGen.value(d, ~subdominant), ~majorChordGen.value(c, ~supertonic), ~majorChordGen.value(c, ~dominant), ~majorChordGen.value(c, ~tonic))});
			 ~current = 'c';
			};
		);

		Pbind(\midinote, Pseq(~progression)).play;
	}, '/chat', n);*/
}
)