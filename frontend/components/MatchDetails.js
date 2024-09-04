import React, { useEffect, useState } from 'react'

import { matchDetailService } from '../services/matchDetailService';

const MatchDetails = () => {
    const [matchData, setMatchData] = useState([])
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchDataFromApi = async () => {
            try {
                const result = await matchDetailService();
                setMatchData(result);
            } catch (err) {
                setError(err.message);
            }
        }
        fetchDataFromApi();
    }, [])

    return (
        <div >
            <h1>Match Details</h1>
            {error && <p >Error: {error}</p>}
            <table >
                <thead>
                    <tr>
                        <th>Match Name</th>
                        <th>Match Date</th>
                        <th>Location</th>
                        <th>Total Payments</th>
                    </tr>
                </thead>
                <tbody>
                    {matchData.map(match => (
                        <tr key={match.matchID}>
                            <td>{match.matchName}</td>
                            <td>{new Date(match.matchDate).toLocaleDateString()}</td>
                            <td>{match.location}</td>
                            <td>${match.totalPayments.toLocaleString()}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    )
}

export default MatchDetails