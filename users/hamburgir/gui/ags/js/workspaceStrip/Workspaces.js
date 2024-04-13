import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";

const dispatch = ws => Hyprland.sendMessage(`dispatch workspace ${ws}`)

const Workspaces = () => Widget.EventBox({
	onScrollUp: () => dispatch('+1'),
	onScrollDown: () => dispatch('-1'),
	class_name: "workspaces",
	child: Widget.Box({
		children: Array.from({length: 10}, (_, i) => i +1).map(i => {
			const btn = Widget.Button({
				setup: self => self.hook(Hyprland, () => {
					self.toggleClassName('active', Hyprland.active.workspace.id === i);
					self.toggleClassName('occupied', (Hyprland.getWorkspace(i)?.windows || 0) > 0);
				}),
				hexpand: true,
				attribute: i,
				label: `${i}`,
				class_name: `${i}`,
				onClicked: () => dispatch(i),
			})
			return btn
		})

		// setup: self => self.hook(Hyprland, () => self.children.forEach(btn => {
		// 	btn.visible = Hyprland.workspaces.some(ws => ws.id === btn.attribute);
		// })),
	})
})

export default ( monitor = 0 ) => Widget.Window({
		monitor,
		exclusivity: "exclusive",
		name: `WorkspaceStrip${monitor}`,
		class_name: `WorkspaceStrip${monitor}`,
		anchor: [ "left", "right", "bottom" ],
		child: Workspaces(),
	})
