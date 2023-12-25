using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class ReportsService : BaseService<Report, ReportDto, ReportUpsertDto, ReportSearchObject, IReportsRepository>, IReportsService
    {
        public ReportsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ReportUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
