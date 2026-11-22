import type { Register } from "claude-code";

// Closed fences only, so a block still streaming gets no button yet.
const FENCE = /^ {0,3}(`{3,}|~{3,})([^\n`]*)\n([\s\S]*?)\n {0,3}\1[ \t]*$/gm;

export const codeBlocks = (md: string) =>
  [...md.matchAll(FENCE)].map((m) => ({
    lang: (m[2] ?? "").trim().split(/\s/)[0] ?? "",
    code: m[3] ?? "",
  }));

export const register: Register = (on) => {
  on("ui.render", { component: "AssistantMessage" }, async ($, e, next) => {
    const blocks = codeBlocks(e.props.text);
    if (blocks.length === 0) return next(e);

    const { Box, Button } = $.ui.resolve(e);
    const copy = async (code: string, surface: typeof e.surface) => {
      const r = await $.ui.copy({ text: code, surface });
      $.ui.toast(r.isCopied ? "Copied code block" : `Copy failed: ${r.reason}`);
    };

    return (
      <Box flexDirection="column">
        {await next(e)}
        <Box flexDirection="row" gap={1} marginLeft={2}>
          {blocks.map((b, i) => (
            <Button
              key={`copy-${i}`}
              plain
              dimColor
              onPress={(press) => copy(b.code, press.surface)}
            >
              {`⧉ copy ${blocks.length > 1 ? `#${i + 1} ` : ""}${b.lang}`.trim()}
            </Button>
          ))}
        </Box>
      </Box>
    );
  });
};
