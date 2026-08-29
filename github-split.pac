// GitHub 分流 PAC：仅 GitHub 相关域名走局域网代理，其余直连
// 代理不可用时自动回退直连（此时由 hosts 加速兜底）
var PROXY = "PROXY 192.168.1.16:10809; DIRECT";

var GITHUB_DOMAINS = [
    "github.com",
    "github.io",
    "github.dev",
    "github.community",
    "github.blog",
    "githubcopilot.com",
    "githubusercontent.com",
    "githubassets.com",
    "githubapp.com",
    "githubstatus.com",
    "ghcr.io",
    "vscode.dev"
];

function FindProxyForURL(url, host) {
    host = host.toLowerCase();
    for (var i = 0; i < GITHUB_DOMAINS.length; i++) {
        var d = GITHUB_DOMAINS[i];
        if (host === d || host.indexOf("." + d, host.length - d.length - 1) !== -1) {
            return PROXY;
        }
    }
    return "DIRECT";
}
