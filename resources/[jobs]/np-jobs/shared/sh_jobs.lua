--[[

    Variables

]]

JOBS = {}

--[[

    Functions

]]

function jobName(job)
    if JOBS[job] then
		return JOBS[job]["name"]
	else
		return "ERROR"
	end
end

function jobDecor(job)
    if JOBS[job] then
		return JOBS[job]["id"]
	else
		return 0
	end
end

function getJobs()
	return JOBS
end

function getJob(pJob, pVar)
	local job = pJob
	if not job then
		job = exports["np-base"]:getChar("job")
	end

	if not JOBS[job] then
		return nil
	end

	local value = JOBS[job][pVar]
	if value == nil then
		value = JOBS[job]
	end

	return value
end

--[[

    Exports

]]

exports("jobName", jobName)
exports("jobDecor", jobDecor)
exports("getJobs", getJobs)
exports("getJob", getJob)