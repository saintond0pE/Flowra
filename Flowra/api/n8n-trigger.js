export default async function handler(req, res) {
    if (req.method !== 'POST') {
        return res.status(405).json({ error: 'Method not allowed' });
    }

    try {
        // Vercel server-side strictly sends standard JSON payload directly to the n8n Cloud webhook
        // This is SERVER-TO-SERVER, so it physically CANNOT be blocked by browser CORS security policies.
        const webhookResponse = await fetch('https://sdfvsd4r5.app.n8n.cloud/webhook-test/45f6b781-c499-4c66-b0fd-cde3b78ce528', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify(req.body)
        });

        // Forward whatever n8n replies back to the frontend
        const text = await webhookResponse.text();
        return res.status(200).json({ success: true, message: 'Fired to n8n successfully from Vercel Edge', response: text });
        
    } catch (error) {
        console.error('Serverless Error:', error);
        return res.status(500).json({ success: false, error: error.message });
    }
}