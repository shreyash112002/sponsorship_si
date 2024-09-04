using Npgsql;
using System.Data.Common;
using System.Data;
using sponsorship.Models;
namespace sponsorship.DAO
{
    public interface ISponsorDao
    {
        Task<List<SponsorPaymentDetails>> GetSponsorPaymentDetails();
        Task<List<MatchPaymentDetails>> GetMatchPaymentDetails();
        Task<List<SponsorMatchSummary>> GetSponsorMatchSummary(int year);
        Task<int> InsertPaymentDetails(PaymentDetails paymentDetails);

    }
}
