This project shows a bug related to `snapshotView(afterScreenUpdates afterUpdates: Bool)` and CSS Animations.
After creating a lot of snapshotViews (~200), the CSS Animations in a WebView are broken and will not animate.

![Screencast GIF](screencast.gif)