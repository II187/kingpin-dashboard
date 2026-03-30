#!/bin/bash
# Deploy Unified Dashboard to GitHub Pages and VPS

echo "🚀 Deploying Unified Dashboard..."

# 1. Copy to VPS web directory
mkdir -p /var/www/html/dashboard
cp /root/.openclaw/workspace/kingpin-dashboard/unified-dashboard.html /var/www/html/dashboard/index.html

# 2. Also copy to GitHub Pages location (for ii187.github.io)
cp /root/.openclaw/workspace/kingpin-dashboard/unified-dashboard.html /root/.openclaw/workspace/kingpin-dashboard/index.html

# 3. Ensure nginx serves it
cat > /etc/nginx/sites-available/dashboard << 'EOF'
server {
    listen 80;
    server_name dashboard.kingpin.xyz;
    root /var/www/html/dashboard;
    index index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
}
EOF

# Enable site
ln -sf /etc/nginx/sites-available/dashboard /etc/nginx/sites-enabled/ 2>/dev/null || true

# Test and reload nginx
nginx -t && systemctl reload nginx

echo "✅ Dashboard deployed!"
echo ""
echo "🌐 URLs:"
echo "  GitHub Pages: https://ii187.github.io/molduk-dashboard/"
echo "  VPS Direct: http://161.35.10.127/dashboard/"
echo ""
echo "📦 Features:"
echo "  • Overview (Stats, Products, Trading)"
echo "  • Products Section ($267 total value)"
echo "  • Live Trading Data"
echo "  • Embedded AI Chat"
echo "  • System Logs"
