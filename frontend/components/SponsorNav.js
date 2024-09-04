import React from 'react'

import { Link } from 'react-router-dom'

const SponsorNav = () => {
    return (
        <nav style={{ display: 'flex', justifyContent: 'space-around', padding: '1rem', backgroundColor: '#f8f9fa', borderBottom: '1px solid #ddd' }}>
          <Link style={{ textDecoration: 'none', color: '#007bff', fontSize: '1rem' }} to='/'>Home</Link>
          <Link style={{ textDecoration: 'none', color: '#007bff', fontSize: '1rem' }} to='/sponsorpaymentdetails'>Sponsors Details</Link>
          <Link style={{ textDecoration: 'none', color: '#007bff', fontSize: '1rem' }} to='/matchpaymentdetails'>Match Details</Link>
          <Link style={{ textDecoration: 'none', color: '#007bff', fontSize: '1rem' }} to='/sponsormatchsummary'>Summary</Link>
          <Link style={{ textDecoration: 'none', color: '#007bff', fontSize: '1rem' }} to='/paymentdetail'>Payment</Link>
        </nav>
      );
    
}

export default SponsorNav