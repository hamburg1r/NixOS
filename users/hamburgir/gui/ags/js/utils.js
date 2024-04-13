// export CustomSeperator = (service, condition) => Widget.Separator({
// 	vpack: "center",
// 	setup: self => {
// 		const visibility = () => {
// 			self.visible = condition && service
// 				? condition(service)
// 				: options.bar.seperators.value
// 		};
//
// 		if (service && condition) self.hook(service, visibility)
// 	}
// })

/** @param {Array<string>} bins */
export function dependencies(bins) {
    const deps = bins.map(bin => {
        const has = Utils.exec(`which ${bin}`);
        if (!has)
            print(`missing dependency: ${bin}`);

        return !!has;
    });

    return deps.every(has => has);
}

/**
* @param {Array<[string, string] | string[]>} collection
* @param {string} item
* @returns {string}
*/
export function substitute(collection, item) {
	return collection.find(([from]) => from === item)?.[1] || item;
}

/** @param {string} icon */
export function getAudioTypeIcon(icon) {
    const substitues = [
        ['audio-headset-bluetooth', icons.audio.type.headset],
        ['audio-card-analog-usb', icons.audio.type.speaker],
        ['audio-card-analog-pci', icons.audio.type.card],
    ];

    return substitute(substitues, icon);
}

